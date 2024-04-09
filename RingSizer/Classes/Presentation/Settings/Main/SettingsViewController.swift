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
	
	private lazy var viewModel = SettingsViewModel()
	
	private let disposeBag = DisposeBag()
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let output = viewModel.configure(input: .init(
			selectedItem: mainView.tableView.selectedAction.asSignal(),
			didTapBack: mainView.backButton.rx.tap.asSignal()
		))
		
		output.elements
			.drive(with: mainView.tableView) { $0.setup(elements: $1) }
			.disposed(by: disposeBag)
		
		output.route
			.emit(with: self) { $0.route($1) }
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
	func route(_ route: SettingsViewModel.Route) {
		switch route {
		case .savedSizes:
			showSavedSizes()
		case let .open(url):
			open(url: url)
		case .back:
			navigationController?.popViewController(animated: true)
		}
	}
	
	func showSavedSizes() {
		let vc = SavedSizesViewController.make()
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func open(url: URL) {
		if UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url)
		}
	}
}
