//
//  SavedSizesViewModel.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 31.03.2024.
//

import RxSwift
import RxCocoa

final class SavedSizesViewModel {
	private let ringManager: RingManagerProtocol = RingManager()
	private let disposeBag = DisposeBag()
}

extension SavedSizesViewModel {
	enum Route {
		case actions([SavedSizesAction])
		case share(SavedRingSizeModel)
		case convert(SavedRingSizeModel)
		case measure
		case close
		case delete
	}
	
	struct Input {
		let selectMoreAction: Signal<SavedRingSizeModel>
		let selectedAction: Signal<SavedSizesAction>
		let didTapClose: Signal<Void>
		let didTapPrimaryButton: Signal<Void>
	}
	
	struct Output {
		let elements: Driver<[SavedRingSizeModel]>
		let route: Signal<Route>
	}
	
	func configure(input: Input) -> Output {
		
		let currentModel = input.selectMoreAction
			.asObservable()
			.share(replay: 1)
		
		let elements = Signal
			.merge(
				RingMediator.shared.savedRingsChange,
				ringManager.loadSavedRings()
			)
			.asDriver(onErrorJustReturn: [])
		
		let actionRoute = input.selectedAction
			.asObservable()
			.withLatestFrom(currentModel) { ($0, $1) }
			.compactMap { action, model -> Route? in
				switch action {
				case .share:
					return .share(model)
				case .convert:
					return .convert(model)
				case .delete:
					return nil
				}
			}
			.asSignal(onErrorSignalWith: .empty())
		
		let route = Signal
			.merge(
				actionRoute,
				input.selectMoreAction.map { _ in .actions(SavedSizesAction.allCases) },
				input.didTapClose.map { _ in .close },
				input.didTapPrimaryButton.map { _ in .measure }
			)
		
		input.selectedAction
			.asObservable()
			.filter { $0 == .delete }
			.withLatestFrom(currentModel)
			.subscribe(with: self) { $0.ringManager.delete(model: $1) }
			.disposed(by: disposeBag)
		
		return Output(
			elements: elements, 
			route: route
		)
	}
}
