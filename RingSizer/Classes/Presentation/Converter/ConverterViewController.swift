//
//  ConverterViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 25.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

class ConverterViewController: UIViewController {
	
	lazy var mainView = ConverterView()
	
	private lazy var viewModel = ConverterViewModel()
	
	private lazy var currentSystem = PublishRelay<MeasurementSystem>()
	private lazy var newSystem = PublishRelay<MeasurementSystem>()
	private lazy var selectedSize = PublishRelay<RingSize>()
	
	private lazy var disposeBag = DisposeBag()
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let output = viewModel.configure(
			input: .init(
				selectedCurrentSystem: currentSystem.asSignal(),
				selectedNewSystem: newSystem.asSignal(),
				selectedSize: selectedSize.asSignal(),
				didTapConvert: mainView.primaryButton.rx.tap.asSignal(),
				didTapCurrentDropdown: mainView.leftDropdown.rx.tap.asSignal(),
				didTapNewDropdown: mainView.rightDropdown.rx.tap.asSignal(),
				didTapSize: mainView.sizeSelector.rx.tap.asSignal()
			)
		)
		
		output.route
			.emit(with: self) { $0.route(route: $1) }
			.disposed(by: disposeBag)
		
		output.currentSystemTitle
			.drive(with: mainView.leftDropdown) { $0.title = $1 }
			.disposed(by: disposeBag)
		
		output.newSystemTitle
			.drive(with: mainView.rightDropdown) { $0.title = $1 }
			.disposed(by: disposeBag)
		
		output.sizeValue
			.drive(with: mainView.sizeSelector) { $0.title = $1 }
			.disposed(by: disposeBag)
		
		output.convertedValue
			.drive(with: mainView.convertedValuelabel) {
				let attrs = TextAttributes()
					.textColor(Appearance.v4DarkGrey)
					.font(Fonts.Sen.regular(size: 58.scale))
					.textAlignment(.center)
				
				$0.attributedText = $1?.attributed(with: attrs)
			}
			.disposed(by: disposeBag)
		
		output.isShowPrimaryButton
			.drive(with: mainView) {
				$0.primaryButton.isHidden = !$1
				$0.convertedValuelabel.isHidden = $1
			}
			.disposed(by: disposeBag)
    }
}

// MARK: Private
private extension ConverterViewController {
	func route(route: ConverterViewModel.Route) {
		switch route {
		case let .openMeasureSystem(type, system):
			openMeasurementSystems(for: type, current: system)
		case let .openSize(current, system):
			openPickSize(system: system, current: current)
		}
	}
	
	func openPickSize(system: MeasurementSystem, current: RingSize?) {
		let vc = PickSizeViewController.make(system: system, current: current) { [weak self] size in
			self?.selectedSize.accept(size)
		}
		present(vc, animated: true)
	}
	
	func openMeasurementSystems(for type: ConverterViewModel.DropdownType, current: MeasurementSystem) {
		let vc = MeasurementSystemsViewController.make(current: current) { [weak self] system in
			switch type {
			case .current:
				self?.currentSystem.accept(system)
			case .new:
				self?.newSystem.accept(system)
			}
		}
		
		let nc = UINavigationController(rootViewController: vc)
		nc.modalPresentationStyle = .pageSheet
		
		if let sheet = nc.sheetPresentationController {
			sheet.prefersGrabberVisible = true
			if #available(iOS 16.0, *) {
				sheet.detents = [.custom(resolver: { _ in return 300.scale })]
			} else {
				sheet.detents = [.medium()]
			}
		}
		
		present(nc, animated: true)
	}
}
