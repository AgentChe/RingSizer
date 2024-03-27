//
//  PickSizeViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 26.03.2024.
//

import UIKit
import RxSwift

class PickSizeViewController: UIViewController {
	
	private lazy var mainView = PickSizeView()
	private var selectedSize: ((RingSize) -> Void)?
	private var initialSize: RingSize?
	
	var system: MeasurementSystem = .au
	private let disposeBag = DisposeBag()
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		mainView.tableView.setup(
			elements: RingSize.allSizes,
			system: system,
			current: initialSize
		)
		
		mainView.primaryButton.rx.tap
			.withLatestFrom(mainView.tableView.didSelectCell.compactMap { $0 })
			.bind(to: Binder(self) {
				$0.selectedSize?($1)
				$0.dismiss(animated: true)
			})
			.disposed(by: disposeBag)
		
		mainView.closeButton.rx.tap
			.bind(to: Binder(self) { base, _ in
				base.dismiss(animated: true)
			})
			.disposed(by: disposeBag)
    }
}

extension PickSizeViewController {
	static func make(system: MeasurementSystem, current: RingSize?, selectedSize: @escaping (RingSize) -> Void) -> PickSizeViewController {
		let vc = PickSizeViewController()
		vc.system = system
		vc.selectedSize = selectedSize
		vc.initialSize = current
		return vc
	}
}
