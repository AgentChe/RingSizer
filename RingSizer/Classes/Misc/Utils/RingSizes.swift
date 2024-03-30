//
//  RingSizes.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 25.03.2024.
//

import Foundation

struct RingSize: Equatable, Codable {
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

enum MeasurementSystem: CaseIterable, Equatable, Codable {
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
		.init(diameter: 14.9, circle: 46.8, iso: 47, us: 4.25, uk: "H 1/2", cn: 8),
		.init(diameter: 15.0, circle: 47.1, iso: 47, us: 4.5, uk: "I", cn: 8),
		.init(diameter: 15.3, circle: 48.0, iso: 48, us: 4.75, uk: "J", cn: 9),
		.init(diameter: 15.5, circle: 48.7, iso: 49, us: 5, uk: "J", cn: 9),
		.init(diameter: 15.7, circle: 49.3, iso: 49, us: 5.25, uk: "K", cn: 10),
		.init(diameter: 15.9, circle: 50.0, iso: 50, us: 5.5, uk: "L", cn: 11),
		.init(diameter: 16.1, circle: 50.6, iso: 50, us: 5.75, uk: "L 1/2", cn: 12),
		.init(diameter: 16.3, circle: 51.2, iso: 51, us: 6, uk: "M", cn: 12),
		.init(diameter: 16.5, circle: 51.9, iso: 52, us: 6.25, uk: "M1 /2", cn: 13),
		.init(diameter: 16.7, circle: 52.5, iso: 52, us: 6.5, uk: "N", cn: 13),
		.init(diameter: 16.9, circle: 53.1, iso: 53, us: 6.75, uk: "N 1/2", cn: 14),
		.init(diameter: 17.1, circle: 53.8, iso: 54, us: 7, uk: "O", cn: 14),
		.init(diameter: 17.3, circle: 54.4, iso: 54, us: 7.25, uk: "O 1/2", cn: 15),
		.init(diameter: 17.5, circle: 55.0, iso: 55, us: 7.5, uk: "P", cn: 15),
		.init(diameter: 17.7, circle: 55.7, iso: 56, us: 7.75, uk: "P 1/2", cn: 16),
		.init(diameter: 17.9, circle: 56.3, iso: 56, us: 8, uk: "Q", cn: 16),
		.init(diameter: 18.0, circle: 56.5, iso: 56, us: 7.5, uk: "O", cn: 15),
		.init(diameter: 18.5, circle: 58.1, iso: 58, us: 8.5, uk: "Q", cn: 17),
		.init(diameter: 19.0, circle: 59.7, iso: 59, us: 9, uk: "R 1/2", cn: 18),
		.init(diameter: 19.5, circle: 61.3, iso: 61, us: 9.5, uk: "S 1/2", cn: 20),
		.init(diameter: 20.0, circle: 62.8, iso: 62, us: 10, uk: "T 1/2", cn: 22),
		.init(diameter: 20.5, circle: 64.4, iso: 64, us: 10.5, uk: "U 1/2", cn: 23),
		.init(diameter: 21.0, circle: 66.0, iso: 66, us: 11.5, uk: "W", cn: 25),
		.init(diameter: 21.5, circle: 67.5, iso: 67, us: 12, uk: "X 1/2", cn: 27),
		.init(diameter: 22.0, circle: 69.1, iso: 69, us: 12.5, uk: "Z", cn: 28),
		.init(diameter: 22.5, circle: 70.7, iso: 70, us: 13, uk: "Z+1", cn: 29),
		.init(diameter: 23.0, circle: 72.3, iso: 72, us: 13.5, uk: "Z+1.5", cn: 31),
		.init(diameter: 23.5, circle: 73.8, iso: 73, us: 14, uk: "Z+2", cn: 32),
		.init(diameter: 24.0, circle: 75.4, iso: 75, us: 14.5, uk: "Z+2.5", cn: 33),
		.init(diameter: 24.5, circle: 76.9, iso: 76, us: 15, uk: "Z+3", cn: 34),
		.init(diameter: 25.0, circle: 78.5, iso: 78, us: 15.5, uk: "Z+3.5", cn: 35),
		.init(diameter: 25.5, circle: 80.1, iso: 80, us: 16, uk: "Z+4", cn: 36),
		.init(diameter: 26.0, circle: 81.6, iso: 81, us: 16.5, uk: "Z+4.5", cn: 37),
		.init(diameter: 26.5, circle: 83.2, iso: 83, us: 17, uk: "Z+5", cn: 38),
		.init(diameter: 27.0, circle: 84.8, iso: 84, us: 17.5, uk: "Z+5.5", cn: 39),
		.init(diameter: 27.5, circle: 86.4, iso: 86, us: 18, uk: "Z+6", cn: 40),
		.init(diameter: 28.0, circle: 87.9, iso: 87, us: 18.5, uk: "Z+6.5", cn: 41),
		.init(diameter: 28.5, circle: 89.5, iso: 89, us: 19, uk: "Z+7", cn: 42),
		.init(diameter: 29.0, circle: 91.1, iso: 91, us: 19.5, uk: "Z+7.5", cn: 43),
		.init(diameter: 29.5, circle: 92.7, iso: 92, us: 20, uk: "Z+8", cn: 44),
		.init(diameter: 30.0, circle: 94.2, iso: 94, us: 20.5, uk: "Z+8.5", cn: 45)
	]
}
