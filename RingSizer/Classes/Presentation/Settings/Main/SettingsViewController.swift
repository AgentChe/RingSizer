//
//  SettingsViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 02.04.2024.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsViewController: UIViewController {
	
	lazy var mainView = SettingsView()
	
	private let disposeBag = DisposeBag()
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		mainView.tableView.setup(elements: SettingItemsModel.allCases)
		
		mainView.tableView.selectedAction
			.asSignal()
			.emit(with: self) { $0.route(action: $1) }
			.disposed(by: disposeBag)
		
		mainView.backButton.rx.tap
			.asSignal()
			.emit(with: self) { base, _ in
				base.navigationController?.popViewController(animated: true)
			}
			.disposed(by: disposeBag)
    }
}

extension SettingsViewController {
	static func make() -> SettingsViewController {
		let vc = SettingsViewController()
		return vc
	}
}

private extension SettingsViewController {
	func route(action: SettingItemsModel) {
		switch action {
		case .savedSizes:
			showSavedSizes()
		case .termsOfUse:
			showTermsOfUse()
		case .privacyPolicy:
			showPrivacyPolicy()
		case .support:
			showSupport()
		}
	}
	
	func showSavedSizes() {
		let vc = SavedSizesViewController.make()
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func showTermsOfUse() {
		
	}
	
	func showPrivacyPolicy() {
		
	}
	
	func showSupport() {
		
	}
}
