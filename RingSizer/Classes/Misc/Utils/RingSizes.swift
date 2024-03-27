//
//  RingSizes.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 25.03.2024.
//

import Foundation

struct RingSize: Equatable {
	let diameter: Double
	let circle: Double
	let iso: Int
	let us: Double
	let uk: String
	let cn: Int
	
	func size(by type: MeasurementSystem) -> String {
		switch type {
		case .eu:
			return "\(iso)"
		case .us:
			return "\(us)"
		case .au:
			return uk
		case .jp:
			return "\(cn)"
		}
	}
}

enum MeasurementSystem: CaseIterable, Equatable {
	case us
	case au
	case eu
	case jp
	
	var name: String {
		switch self {
		case .eu:
			"EU/ISO"
		case .us:
			"US/CA"
		case .au:
			"AU/UK"
		case .jp:
			"JP/CN"
		}
	}
	
	var description: String {
		switch self {
		case .eu:
			"MeasurementSystems.EU".localized
		case .us:
			"MeasurementSystems.US".localized
		case .au:
			"MeasurementSystems.AU".localized
		case .jp:
			"MeasurementSystems.JP".localized
		}
	}
}

extension RingSize {
	
	static let allSizes: [Self] = [
		.init(diameter: 14, circle: 44, iso: 44, us: 3, uk: "F", cn: 4),
		.init(diameter: 14.1, circle: 44.3, iso: 44, us: 3.25, uk: "F", cn: 5),
		.init(diameter: 14.3, circle: 45, iso: 45, us: 3.5, uk: "G", cn: 6),
		.init(diameter: 14.5, circle: 45.5, iso: 45, us: 3.75, uk: "G", cn: 7),
		.init(diameter: 14.6, circle: 46, iso: 46, us: 4, uk: "H", cn: 7),
		.init(diameter: 14.9, circle: 46.8, iso: 47, us: 4.25, uk: "H\u{00BD}", cn: 8)
	]
}
