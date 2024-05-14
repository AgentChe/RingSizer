//
//  MainViewCoordinator.swift
//  Soccer
//
//  Created by Андрей Чернышев on 07.07.2022.
//

import UIKit

final class MainViewCoordinator {
    weak var parentVC: MainViewController?
    
    lazy var ringSizerVC = RingSizerViewController()
    lazy var converterVC = ConverterViewController()
    lazy var fingerSizerVC = FingerSizerOnboardingViewController()
    lazy var wallpapersVC = WallpapersCategoriesViewController.make()
    
    private var previousVC: UIViewController?
    
    init(parentVC: MainViewController) {
        self.parentVC = parentVC
    }
    
    func change(tab: TabView.Tab) {
        parentVC?.mainView.tabView.selectedTab = tab
        
        switch tab {
        case .ringSizer:
            changeVC(on: ringSizerVC)
        case let .converter(model):
			if let model {
				converterVC.convert(model: model)
			}
            changeVC(on: converterVC)
        case .fingerSizer:
            changeVC(on: fingerSizerVC)
        case .wallpapers:
            changeVC(on: wallpapersVC)
        }
    }
}

// MARK: Private
private extension MainViewCoordinator {
    func changeVC(on vc: UIViewController) {
        if let previousVC = self.previousVC {
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
    
        self.previousVC = vc
        
        guard let parentVC = self.parentVC else {
            return
        }
    
        parentVC.addChild(vc)
        vc.view.frame = parentVC.mainView.container.bounds
        parentVC.mainView.container.addSubview(vc.view)
        vc.willMove(toParent: parentVC)
    }
}
