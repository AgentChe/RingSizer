//
//  ConverterViewModel.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 26.03.2024.
//

import RxSwift
import RxCocoa

final class ConverterViewModel {
	enum DropdownType {
		case current
		case new
	}
	
	enum Route {
		case openMeasureSystem(DropdownType, system: MeasurementSystem)
		case openSize(current: RingSize?, system: MeasurementSystem)
		case settings
	}
	
	struct Input {
		let selectedCurrentSystem: Signal<MeasurementSystem>
		let selectedNewSystem: Signal<MeasurementSystem>
		let selectedSize: Signal<RingSize>
		let didTapConvert: Signal<Void>
		let didTapCurrentDropdown: Signal<Void>
		let didTapNewDropdown: Signal<Void>
		let didTapSize: Signal<Void>
		let didTapSettings: Signal<Void>
	}
	
	struct Output {
		let currentSystemTitle: Driver<String>
		let newSystemTitle: Driver<String>
		let sizeValue: Driver<String?>
		let convertedValue: Driver<String?>
		let isShowPrimaryButton: Driver<Bool>
		let route: Signal<Route>
	}
	
	private lazy var sessionManager = SessionManager()
}

// MARK: Public
extension ConverterViewModel {
	func configure(input: Input) -> Output {
		
		let currentSystem = input.selectedCurrentSystem
			.asObservable()
			.startWith(.us)
			.share(replay: 1)
		
		let newSystem = input.selectedNewSystem
			.asObservable()
			.startWith(.eu)
			.share(replay: 1)
		
		let currentSystemTitle = currentSystem
			.map { $0.name }
			.asDriver(onErrorDriveWith: .empty())
		
		let newSystemTitle = newSystem
			.map { $0.name }
			.asDriver(onErrorDriveWith: .empty())
		
		let currentSize = input.selectedSize
			.asObservable()
			.map { $0 }
			.startWith(nil)
			.share(replay: 1)
		
		let hasActiveSubscription = makeActiveSubscription()
		
		let showPrimary = Observable
			.merge(
				currentSystem.map { _ in true },
				newSystem.map { _ in true },
				currentSize.map { _ in true }
			)
		
		let hidePrimary = input.didTapConvert
			.asObservable()
			.map { _ in false }
		
		let isShowPrimaryButton = hasActiveSubscription
			.flatMapLatest { isActive in
				isActive 
					? .just(false) 
					: Observable
						.merge(showPrimary, hidePrimary)
						.distinctUntilChanged()
						.asDriver(onErrorJustReturn: true)
			}
		
		let sizeValue = Observable
			.combineLatest(currentSize, currentSystem) { size, system in
				size.flatMap { $0.isAvailableSize(for: system) ? $0.size(by: system) : nil }
			}
			.asDriver(onErrorJustReturn: nil)
		
		let convertedValueResult = Observable
			.combineLatest(currentSize, newSystem, currentSystem) { size, newSystem, currentSystem in
				size.flatMap { $0.isAvailableSize(for: currentSystem) ? $0.size(by: newSystem) : nil }
			}
			.asDriver(onErrorJustReturn: nil)
		
		let convertedValue = hasActiveSubscription
			.flatMapLatest { isActive in
				isActive
					? convertedValueResult
					: input.didTapConvert.withLatestFrom(convertedValueResult).asDriver(onErrorJustReturn: nil)
			}
		
		let route = Observable<Route>
			.merge(
				input.didTapCurrentDropdown
					.asObservable()
					.withLatestFrom(currentSystem)
					.map { .openMeasureSystem(.current, system: $0) },
				input.didTapNewDropdown
					.asObservable()
					.withLatestFrom(newSystem)
					.map { .openMeasureSystem(.new, system: $0) },
				input.didTapSize
					.asObservable()
					.withLatestFrom(Observable.combineLatest(currentSystem, currentSize))
					.map { .openSize(current: $1, system: $0) },
				input.didTapSettings
					.asObservable()
					.map { _ in .settings }
			)
			.asSignal(onErrorSignalWith: .empty())
		
		return Output(
			currentSystemTitle: currentSystemTitle,
			newSystemTitle: newSystemTitle,
			sizeValue: sizeValue,
			convertedValue: convertedValue, 
			isShowPrimaryButton: isShowPrimaryButton,
			route: route
		)
	}
}

private extension ConverterViewModel {
	func makeActiveSubscription() -> Driver<Bool> {
		PurchaseValidationObserver.shared
			.didValidatedWithActiveSubscription
			.map { [weak self] in self?.sessionManager.hasActiveSubscriptions() ?? false }
			.startWith(sessionManager.hasActiveSubscriptions())
			.asDriver(onErrorJustReturn: false)
	}
}
