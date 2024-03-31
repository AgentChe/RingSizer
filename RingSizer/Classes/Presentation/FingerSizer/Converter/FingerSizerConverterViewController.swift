//
//  FingerSizerConverterViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 30.03.2024.
//

import UIKit
import RxSwift
import RxCocoa


class FingerSizerConverterViewController: UIViewController {
	
	lazy var mainView = FingerSizerConverterView()
	
	private let viewModel: FingerSizerConverterViewModel
	private let selectedMeasureSystem = PublishRelay<MeasurementSystem>()
	private let disposeBag = DisposeBag()
	
	init(hand: Hand, size: RingSize) {
		self.viewModel = .init(hand: hand, size: size)
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
		
		let output = viewModel.configure(input: .init(
			selectedMeasureSystem: selectedMeasureSystem.asSignal(),
			didTapDropdown: mainView.dropdown.rx.tap.asSignal(),
			didTapSave: mainView.primaryButton.rx.tap.asSignal(),
			didTapBack: mainView.backButton.rx.tap.asSignal()
		))
		
		output.currentMeasureSystem
			.map { $0.name }
			.drive(with: mainView.dropdown) { $0.title = $1 }
			.disposed(by: disposeBag)
		
		output.convertedSizeValue
			.drive(with: mainView.sizeLabel) {
				let attrs = TextAttributes()
					.textColor(Appearance.v4DarkGrey)
					.font(Fonts.Sen.regular(size: 58.scale))
					.textAlignment(.center)
				
				$0.attributedText = $1.attributed(with: attrs)
			}
			.disposed(by: disposeBag)
		
		output.route
			.emit(with: self) { $0.route(route: $1) }
			.disposed(by: disposeBag)
    }
}

extension FingerSizerConverterViewController {
	static func make(hand: Hand, size: RingSize) -> FingerSizerConverterViewController {
		let vc = FingerSizerConverterViewController(hand: hand, size: size)
		return vc
	}
}

private extension FingerSizerConverterViewController {
	func route(route: FingerSizerConverterViewModel.Route) {
		switch route {
		case let .openMeasureSystem(system):
			openMeasurementSystems(for: system)
		case let .save(hand, size, system):
			openSaveSize(hand: hand, size: size, system: system)
		case .back:
			navigationController?.popViewController(animated: true)
		}
	}
	
	func openMeasurementSystems(for current: MeasurementSystem) {
		let vc = MeasurementSystemsViewController.make(current: current) { [weak self] system in
			self?.selectedMeasureSystem.accept(system)
		}
		present(vc, animated: true)
	}
	
	func openSaveSize(hand: Hand, size: RingSize, system: MeasurementSystem) {
		let vc = SaveRingSizeViewController.make(size: size, system: system, hand: hand)
		present(vc, animated: true)
	}
}
