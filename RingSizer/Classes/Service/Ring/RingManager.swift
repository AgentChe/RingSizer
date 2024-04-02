//
//  RingManager.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 29.03.2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol RingManagerProtocol {
	func loadSavedRings() -> Signal<[SavedRingSizeModel]>
	func save(model: SavedRingSizeModel)
	func delete(model: SavedRingSizeModel)
}

final class RingManager: RingManagerProtocol {
	
	func save(model: SavedRingSizeModel) {
		var elements = cachedSizes()
		elements.append(model)
		
		let data = try? JSONEncoder().encode(elements)
		
		UserDefaults.standard.set(data, forKey: Constants.ringSizeKey)
		
		RingMediator.shared.notify(models: elements)
	}
	
	func delete(model: SavedRingSizeModel) {
		var elements = cachedSizes()
		elements.removeAll(where: { $0.id == model.id })
		
		let data = try? JSONEncoder().encode(elements)
		
		UserDefaults.standard.set(data, forKey: Constants.ringSizeKey)
		
		RingMediator.shared.notify(models: elements)
	}
	
	func loadSavedRings() -> Signal<[SavedRingSizeModel]> {
		return .just(cachedSizes())
	}
}


private extension RingManager {
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
