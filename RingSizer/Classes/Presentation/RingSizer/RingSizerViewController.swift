//
//  RingSizerViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 27.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

class RingSizerViewController: UIViewController {
	lazy var mainView = RingSizerView()
	
	private lazy var viewModel = RingSizerViewModel()
	private let selectedMeasureSystem = PublishRelay<MeasurementSystem>()
	private lazy var disposeBag = DisposeBag()
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		let output = viewModel.configure(input: .init(
			didTapLeft: mainView.leftButton.rx.tap.asSignal(),
			didTapRight: mainView.rightButton.rx.tap.asSignal(),
			didTapSave: mainView.primaryButton.rx.tap.asSignal(),
			sliderValue: mainView.sliderView.rx.value.asDriver(),
			selectedMeasureSystem: selectedMeasureSystem.asSignal(), 
			didTapDropdown: mainView.dropdownView.rx.tap.asSignal(), 
			didTapHelp: mainView.didTapHelp.asSignal()
		))
		
		output.currenSizeValue
			.drive(with: mainView.ringView) { $0.currentSize = $1 }
			.disposed(by: disposeBag)
		
		output.currentSliderValue
			.drive(mainView.sliderView.rx.value)
			.disposed(by: disposeBag)
		
		output.currentMeasureSystem
			.map { $0.name }
			.drive(with: mainView.dropdownView) { $0.title = $1 }
			.disposed(by: disposeBag)
		
		output.convertedSizeValue
			.drive(with: mainView.convertedValuelabel) {
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

// MARK: Private
private extension RingSizerViewController {
	func route(route: RingSizerViewModel.Route) {
		switch route {
		case let .openMeasureSystem(system):
			openMeasurementSystems(for: system)
		case let .save(size, system):
			openSaveSize(size: size, system: system)
		case .help:
			openHelp()
		}
	}
	
	func openMeasurementSystems(for current: MeasurementSystem) {
		let vc = MeasurementSystemsViewController.make(current: current) { [weak self] system in
			self?.selectedMeasureSystem.accept(system)
		}
		present(vc, animated: true)
	}
	
	func openSaveSize(size: RingSize, system: MeasurementSystem) {
		let vc = SaveRingSizeViewController.make(size: size, system: system)
		present(vc, animated: true)
	}
	
	func openHelp() {
		let vc = HelpViewController.make()
		vc.modalPresentationStyle = .custom
		vc.transitioningDelegate = self
		present(vc, animated: true)
	}
}

// MARK: UIViewControllerTransitioningDelegate
extension RingSizerViewController: UIViewControllerTransitioningDelegate {
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		AlertTransitonAnimator(duration: 0.5, type: .present)
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		AlertTransitonAnimator(duration: 0.5, type: .dismiss)
	}
}
