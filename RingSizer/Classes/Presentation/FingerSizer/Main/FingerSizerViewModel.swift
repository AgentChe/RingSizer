//
//  FingerSizerViewModel.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 30.03.2024.
//

import RxSwift
import RxCocoa

final class FingerSizerViewModel {
	
	enum Route {
		case converter(hand: Hand, size: RingSize)
		case back
	}
	
	struct Input {
		let sliderValue: Driver<Float>
		let didTapContinue: Signal<Void>
		let didTapLeftChange: Signal<Void>
		let didTapRightChange: Signal<Void>
		let didTapBack: Signal<Void>
	}
	
	struct Output {
		let currenSizeValue: Driver<RingSize>
		let currentHand: Driver<Hand>
		let route: Signal<Route>
	}
}

extension FingerSizerViewModel {
	func configure(input: Input) -> Output {
		let currentHand = Signal<Hand>
			.merge(
				input.didTapLeftChange.map { _ in .left },
				input.didTapRightChange.map { _ in .right }
			)
			.asObservable()
			.startWith(.left)
			.share(replay: 1)
		
		let currentSize = input.sliderValue
			.asObservable()
			.map { Int($0) }
			.startWith(0)
			.distinctUntilChanged()
			.compactMap { index -> RingSize? in
				guard RingSize.allSizes.indices.contains(index) else { return nil }
				return RingSize.allSizes[index]
			}
			.share(replay: 1)
		
		let convertData = Observable
			.combineLatest(currentHand, currentSize)
		
		let converterRoute = input.didTapContinue
			.asObservable()
			.withLatestFrom(convertData) { Route.converter(hand: $1.0, size: $1.1) }
			.asSignal(onErrorSignalWith: .empty())
		
		let route = Signal
			.merge(
				converterRoute,
				input.didTapBack.map { _ in .back }
			)
		
		return Output(
			currenSizeValue: currentSize.asDriver(onErrorDriveWith: .empty()),
			currentHand: currentHand.asDriver(onErrorJustReturn: .right),
			route: route
		)
	}
}
