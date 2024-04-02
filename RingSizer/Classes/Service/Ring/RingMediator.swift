//
//  RingMediator.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 03.04.2024.
//

import RxSwift
import RxCocoa

final class RingMediator {
	static let shared = RingMediator()
	
	private lazy var savedRingsChangeTrigger = PublishRelay<[SavedRingSizeModel]>()
	
	private init() {}
}

// MARK: Public
extension RingMediator {
	func notify(models: [SavedRingSizeModel]) {
		DispatchQueue.main.async { [weak self] in
			self?.savedRingsChangeTrigger.accept(models)
		}
	}
}

// MARK: Public (Rx)
extension RingMediator {
	var savedRingsChange: Signal<[SavedRingSizeModel]> {
		return savedRingsChangeTrigger.asSignal()
	}
}
