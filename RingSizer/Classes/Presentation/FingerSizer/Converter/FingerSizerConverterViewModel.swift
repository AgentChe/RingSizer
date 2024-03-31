//
//  FingerSizerConverterViewModel.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 31.03.2024.
//

import RxCocoa
import RxSwift

final class FingerSizerConverterViewModel {
	let hand: Hand
	let size: RingSize
	
	init(hand: Hand, size: RingSize) {
		self.hand = hand
		self.size = size
	}
}

extension FingerSizerConverterViewModel {
	enum Route {
		case save(Hand, RingSize, MeasurementSystem)
		case openMeasureSystem(MeasurementSystem)
		case back
	}
	
	struct Input {
		let selectedMeasureSystem: Signal<MeasurementSystem>
		let didTapDropdown: Signal<Void>
		let didTapSave: Signal<Void>
		let didTapBack: Signal<Void>
	}
	
	struct Output {
		let convertedSizeValue: Driver<String>
		let currentMeasureSystem: Driver<MeasurementSystem>
		let route: Signal<Route>
	}
	
	func configure(input: Input) -> Output {
		let currentMeasureSystem = input.selectedMeasureSystem
			.asObservable()
			.startWith(.us)
			.share(replay: 1)
		
		let convertedSizeValue = currentMeasureSystem
			.map { [size] in size.size(by: $0) }
			.asDriver(onErrorJustReturn: "")
		
		let openMeasureSystem = input.didTapDropdown
			.asObservable()
			.withLatestFrom(currentMeasureSystem) { _, value in Route.openMeasureSystem(value) }
			.asSignal(onErrorSignalWith: .empty())
		
		let openSaveSize = input.didTapSave
			.asObservable()
			.withLatestFrom(currentMeasureSystem)
			.map { [hand, size] in Route.save(hand, size, $0) }
			.asSignal(onErrorSignalWith: .empty())
		
		let route = Signal
			.merge(
				openMeasureSystem,
				openSaveSize,
				input.didTapBack.map { _ in .back }
			)
		
		return Output(
			convertedSizeValue: convertedSizeValue,
			currentMeasureSystem: currentMeasureSystem.asDriver(onErrorDriveWith: .empty()),
			route: route
		)
	}
}
