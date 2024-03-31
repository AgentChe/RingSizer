//
//  MeasurementSystemsViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 26.03.2024.
//

import UIKit
import RxSwift

class MeasurementSystemsViewController: UIViewController {
	
	private lazy var mainView = MeasurementSystemsView()
	private var current: MeasurementSystem = .au
	
	private var didSelectSystem: ((MeasurementSystem) -> Void)?
	private let disposeBag = DisposeBag()
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		mainView.tableView.setup(elements: MeasurementSystem.allCases, current: current)
		
		mainView.tableView.didSelectCell
			.bind(with: self, onNext: {
				$0.didSelectSystem?($1)
				$0.dismiss(animated: true)
			})
			.disposed(by: disposeBag)
    }
}

extension MeasurementSystemsViewController {
	static func make(current: MeasurementSystem, didSelect: @escaping (MeasurementSystem) -> Void) -> NavigationController {
		let vc = MeasurementSystemsViewController()
		vc.current = current
		vc.didSelectSystem = didSelect
		
		let nc = NavigationController(rootViewController: vc)
		nc.modalPresentationStyle = .pageSheet
		
		if let sheet = nc.sheetPresentationController {
			sheet.prefersGrabberVisible = true
			if #available(iOS 16.0, *) {
				sheet.detents = [.custom(resolver: { _ in return 300.scale })]
			} else {
				sheet.detents = [.medium()]
			}
		}
		return nc
	}
}
