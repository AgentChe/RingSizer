//
//  FingerSizerViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 30.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

class FingerSizerViewController: UIViewController {
	
	lazy var mainView = FingerSizerView()
	
	private let viewModel = FingerSizerViewModel()
	private let disposeBag = DisposeBag()
	
	override func loadView() {
		view = mainView
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		let output = viewModel.configure(input: .init(
			sliderValue: mainView.sliderView.slider.rx.value.asDriver(),
			didTapContinue: mainView.primaryButton.rx.tap.asSignal(),
			didTapLeftChange: mainView.leftHandButton.rx.tap.asSignal(),
			didTapRightChange: mainView.rightHandButton.rx.tap.asSignal(), 
			didTapBack: mainView.backButton.rx.tap.asSignal()
		))
		
		output.currenSizeValue
			.drive(with: mainView.fingerView) { $0.currentSize = $1 }
			.disposed(by: disposeBag)
		
		output.currentHand
			.drive(with: mainView) { $0.changeHand(hand: $1) }
			.disposed(by: disposeBag)
		
		output.route
			.emit(with: self) { $0.route(route: $1) }
			.disposed(by: disposeBag)
    }
}

extension FingerSizerViewController {
	static func make() -> FingerSizerViewController {
		let vc = FingerSizerViewController()
		return vc
	}
}

private extension FingerSizerViewController {
	func route(route: FingerSizerViewModel.Route) {
		switch route {
		case let .converter(hand, size):
			showConverter(hand: hand, size: size)
		case .back:
			navigationController?.popViewController(animated: true)
		}
	}
	
	func showConverter(hand: Hand, size: RingSize) {
		let vc = FingerSizerConverterViewController.make(hand: hand, size: size)
		navigationController?.pushViewController(vc, animated: true)
	}
}
