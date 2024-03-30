//
//  SaveRingSizeViewModel.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 28.03.2024.
//

import RxCocoa
import RxSwift

final class SaveRingSizeViewModel {
	let size: RingSize
	let measureSystem: MeasurementSystem
	
	private let ringManager = RingManager.shared
	
	init(size: RingSize, measureSystem: MeasurementSystem) {
		self.size = size
		self.measureSystem = measureSystem
	}
}

// MARK: Public
extension SaveRingSizeViewModel {
	typealias Section = SaveRingSizeCollectionView.Section
	typealias CellItem = SaveRingSizeCollectionView.SectionItem
	
	struct Input {
		let selectedFinger: Observable<Finger>
		let selectedHand: Observable<Hand>
		let ringName: Observable<String>
		let didTapPrimary: Signal<Void>
	}
	
	struct Output {
		let dataSource: Driver<[Section]>
		let closeSignal: Signal<Void>
	}
	
	func configure(input: Input) -> Output {
		
		let savingData = Observable
			.combineLatest(input.selectedFinger, input.selectedHand, input.ringName)
		
		let closeSignal = input.didTapPrimary
			.asObservable()
			.withLatestFrom(savingData)
			.map { [size, measureSystem] finger, hand, name in
				return SavedRingSizeModel(
					name: name,
					hand: hand,
					finger: finger,
					ringSize: size,
					measureSystem: measureSystem
				)
			}
			.do(onNext: { [weak self] in self?.ringManager.save(model: $0) })
			.map { _ in () }
			.asSignal(onErrorSignalWith: .empty())
		
		return Output(
			dataSource: makeDataSource(), 
			closeSignal: closeSignal
		)
	}
}

// MARK: Private
private extension SaveRingSizeViewModel {
	func makeDataSource() -> Driver<[Section]> {
		let dataSource = [
			Section(
				title: "SaveSize.Title".localized,
				items: [.field]
			),
			Section(
				title: "SaveSize.Hand".localized,
				items: Hand.allCases.reduce(into: [.expandableHeader("SaveSize.RingHand".localized)]) { $0.append(.hand($1)) }
			),
			Section(
				title: "SaveSize.Finger".localized,
				items: Finger.allCases.reduce(into: [.expandableHeader("SaveSize.RingFinger".localized)]) { $0.append(.finger($1)) }
			)
		]
		
		return .just(dataSource)
	}
}
