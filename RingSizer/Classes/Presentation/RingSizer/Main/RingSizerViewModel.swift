//
//  RingSizeViewModel.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 27.03.2024.
//

import RxSwift
import RxCocoa

final class RingSizerViewModel {
	
	enum Route {
		case save(RingSize, MeasurementSystem)
		case openMeasureSystem(system: MeasurementSystem)
		case help
		case settings
	}
	
	struct Input {
		let didTapLeft: Signal<Void>
		let didTapRight: Signal<Void>
		let didTapSave: Signal<Void>
		let sliderValue: Driver<Float>
		let selectedMeasureSystem: Signal<MeasurementSystem>
		let didTapDropdown: Signal<Void>
		let didTapHelp: Signal<Void>
		let didTapSettings: Signal<Void>
	}
	
	struct Output {
		let currentSliderValue: Driver<Float>
		let convertedSizeValue: Driver<String>
		let currenSizeValue: Driver<RingSize>
		let currentMeasureSystem: Driver<MeasurementSystem>
		let route: Signal<Route>
	}
}

extension RingSizerViewModel {
	func configure(input: Input) -> Output {
		
		enum Action {
			case next
			case previos
			case value(Int)
		}
		
		let currentIndex = Observable<Action>
			.merge(
				input.didTapLeft.map { .previos }.asObservable(),
				input.didTapRight.map { .next }.asObservable(),
				input.sliderValue.map { Int($0) }.distinctUntilChanged().map { .value($0) }.asObservable()
			)
			.startWith(.value(0))
			.scan(into: 0) { value, action in
				switch action {
				case .previos:
					value = max(value - 1, 0)
				case .next:
					value = min(value + 1, RingSize.allSizes.count - 1)
				case let .value(element):
					value = max(min(element, RingSize.allSizes.count - 1), 0)
				}
			}
			.share(replay: 1)
		
		let currentSize = currentIndex
			.map { RingSize.allSizes[$0] }
		
		let currentMeasureSystem = input.selectedMeasureSystem
			.asObservable()
			.startWith(.us)
			.share(replay: 1)
		
		let currentSizeValue = Observable
			.combineLatest(currentSize, currentMeasureSystem) { $0.size(by: $1) }
			.asDriver(onErrorJustReturn: "")
		
		let openMeasureSystem = input.didTapDropdown
			.asObservable()
			.withLatestFrom(currentMeasureSystem) { _, value in Route.openMeasureSystem(system: value) }
			.asSignal(onErrorSignalWith: .empty())
		
		let openSaveRing = input.didTapSave
			.asObservable()
			.withLatestFrom(Observable.combineLatest(currentSize, currentMeasureSystem))
			.map { Route.save($0, $1) }
			.asSignal(onErrorSignalWith: .empty())
		
		let route = Signal
			.merge(
				openMeasureSystem,
				openSaveRing,
				input.didTapHelp.map { _ in .help },
				input.didTapSettings.map { _ in .settings }
			)
		
		return Output(
			currentSliderValue: currentIndex.map { Float($0) }.asDriver(onErrorJustReturn: 0),
			convertedSizeValue: currentSizeValue,
			currenSizeValue: currentSize.asDriver(onErrorDriveWith: .empty()), 
			currentMeasureSystem: currentMeasureSystem.asDriver(onErrorDriveWith: .empty()), 
			route: route
		)
	}
}
