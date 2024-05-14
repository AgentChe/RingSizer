//
//  WallpapersViewController.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import UIKit
import RxSwift

final class WallpapersViewController: UIViewController {
    private lazy var mainView = WallpapersView(title: category.name)
    
    private lazy var viewModel = WallpapersViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private let category: WallpaperCategory
    
    private init(category: WallpaperCategory) {
        self.category = category
        
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
        
        let output = viewModel.configure(input: WallpapersViewModel.Input(
            category: category,
            didTapClose: mainView.backButton.rx.tap.asSignal(),
            didSelect: mainView.collectionView.didSelect
        ))
        
        output.elements
            .drive(Binder(mainView.collectionView) { base, elements in
                base.setup(elements: elements)
            })
            .disposed(by: disposeBag)
        
        output.route
            .drive(Binder(self) { base, route in
                base.route(route)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Public
extension WallpapersViewController {
    static func make(category: WallpaperCategory) -> WallpapersViewController {
        let vc = WallpapersViewController(category: category)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: Private
private extension WallpapersViewController {
    func route(_ route: WallpapersViewModel.Route) {
        switch route {
        case .close:
            navigationController?.popViewController(animated: true)
        case let .selected((category, wallpaper)):
            let vc = WallpapersPreviewViewController.make(category: category, selected: wallpaper)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
