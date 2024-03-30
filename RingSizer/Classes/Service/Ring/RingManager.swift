//
//  RingManager.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 29.03.2024.
//

import Foundation
import RxSwift
import RxCocoa

final class RingManager {
	
	static let shared = RingManager()
	lazy var elements = loadSavedRingSizes().share(replay: 1)
	
	private let updateSignal = PublishRelay<Void>()
	
	private init() {}
	
	func save(model: SavedRingSizeModel) {
		var elements = cachedSizes()
		elements.append(model)
		
		let data = try? JSONEncoder().encode(elements)
		
		UserDefaults.standard.set(data, forKey: Constants.ringSizeKey)
		
		updateSignal.accept(())
	}
	
	func delete(model: SavedRingSizeModel) {
		var elements = cachedSizes()
		elements.removeAll(where: { $0.id == model.id })
		
		let data = try? JSONEncoder().encode(elements)
		
		UserDefaults.standard.set(data, forKey: Constants.ringSizeKey)
		
		updateSignal.accept(())
	}
}


private extension RingManager {
	func loadSavedRingSizes() -> Observable<[SavedRingSizeModel]> {
		updateSignal
			.startWith(())
			.compactMap { [weak self] _ in self?.cachedSizes() }
	}
	
	func cachedSizes() -> [SavedRingSizeModel] {
		guard let data = UserDefaults.standard.data(forKey: Constants.ringSizeKey) else {
			return []
		}
		
		let items = try? JSONDecoder().decode([SavedRingSizeModel].self, from: data)
		return items ?? []
	}
}

private extension RingManager {
	enum Constants {
		static let ringSizeKey = "ring_manager_ring_size_manager_key"
	}
}
