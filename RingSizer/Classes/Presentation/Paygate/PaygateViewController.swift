//
//  PaygateViewController.swift
//  CodeChallenge
//
//  Created by Андрей Чернышев on 20.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class PaygateViewController: UIViewController {
    lazy var mainView = PaygateView()
    
    private lazy var viewModel = PaygateViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private let didClose: (() -> Void)?
    
    private init(didClose: (() -> Void)?) {
        self.didClose = didClose
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AmplitudeManager.shared
            .logEvent(name: "Paygate Screen")
        
        Observable
            .merge(
                mainView.productLeftButton.rx.tap.map { (true, false) },
                mainView.productRightButton.rx.tap.map { (false, true) }
            )
            .startWith((false, true))
            .bind(to: Binder(mainView) { base, args in
                base.productLeftButton.marked = args.0
                base.productRightButton.marked = args.1
            })
            .disposed(by: disposeBag)
        
        let didBuy = mainView.buyButton.rx.tap
            .compactMap { [weak self] void -> String? in
                guard let self else {
                    return nil
                }

                let id = [
                    self.mainView.productLeftButton,
                    self.mainView.productRightButton
                ].first(where: { $0.marked })?.product?.id

                return id
            }
            .asSignal(onErrorSignalWith: .never())
        
        let output = viewModel.configure(input: PaygateViewModel.Input(
            didTapClose: mainView.closeButton.rx.tap.asSignal(),
            didTapBuy: didBuy,
            didTapRestore: mainView.restoreButton.rx.tap.asSignal(),
            didTapTermsOfUse: mainView.didTapTermsOfUse,
            didTapPrivacyPolicy: mainView.didTapPrivacyPolicy
        ))
        
        output.activity
            .drive(Binder(self) { base, activity in
                base.activity(activity)
            })
            .disposed(by: disposeBag)
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
        
        output.products
            .drive(Binder(mainView) { base, products in
                base.productLeftButton.setup(product: products.monthly)
                base.productRightButton.setup(product: products.yearly, discountBy: products.monthly)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension PaygateViewController {
    static func make(didClose: (() -> Void)? = nil) -> PaygateViewController {
        let vc = PaygateViewController(didClose: didClose)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: Private
private extension PaygateViewController {
    func activity(_ activity: Bool) {
        activity ? mainView.preloader.startAnimating() : mainView.preloader.stopAnimating()

        [
            mainView.productLeftButton,
            mainView.productRightButton,
            mainView.buyButton,
            mainView.restoreButton
        ].forEach { $0.isHidden = activity }
    }
    
    func route(_ route: PaygateViewModel.Route) {
        switch route {
        case .dismiss:
            dismiss(animated: true) { [weak self] in
                self?.didClose?()
            }
        case .error:
            showError()
        case .open(let url):
            UIApplication.shared.open(url)
        }
    }
    
    func showError() {
        let alert = UIAlertController(title: "Paygate.Error.Title".localized, message: "Paygate.Error.Text".localized, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Paygate.Error.Button".localized, style: .cancel)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
