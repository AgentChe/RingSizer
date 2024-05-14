//
//  WallpapersCategoriesViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import UIKit
import RxSwift

final class WallpapersCategoriesViewController: UIViewController {
    private lazy var mainView = WallpapersCategoriesView()
    
    private lazy var viewModel = WallpapersCategoriesViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let output = viewModel.configure(input: WallpapersCategoriesViewModel.Input(
            didSelect: mainView.tableView.didSelect,
            didTapSettings: mainView.headerView.button.rx.tap.asSignal()
        ))
        
        output.elements
            .drive(Binder(mainView.tableView) { base, elements in
                base.setup(elements: elements) 
            })
            .disposed(by: disposeBag)
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
        
        output.activity
            .drive(Binder(mainView.preloader) { base, activity in
                activity ? base.startAnimating() : base.stopAnimating()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension WallpapersCategoriesViewController {
    static func make() -> WallpapersCategoriesViewController {
        let vc = WallpapersCategoriesViewController()
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: Private
private extension WallpapersCategoriesViewController {
    func route(_ route: WallpapersCategoriesViewModel.Route) {
        switch route {
        case .selected(let category):
            let vc = WallpapersViewController.make(category: category)
            navigationController?.pushViewController(vc, animated: true)
        case .settings:
            let vc = SettingsViewController.make()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
