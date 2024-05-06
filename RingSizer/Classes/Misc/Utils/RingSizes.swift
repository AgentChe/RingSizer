//
//  RingSizes.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 25.03.2024.
//

import Foundation

struct RingSize: Equatable, Codable {
	let diameter: Double
	let iso: Double
	let us: String?
	let uk: String?
	let cn: Int
	
	func size(by type: MeasurementSystem) -> String {
		switch type {
		case .eu:
			return "\(iso)"
		case .us:
			return us ?? "n/a"
		case .au:
			return uk ?? "n/a"
		case .jp:
			return "\(cn)"
		}
	}

	func isAvailableSize(for type: MeasurementSystem) -> Bool {
		switch type {
		case .eu:
			return iso != 0
		case .us:
			return us != nil
		case .au:
			return uk != nil
		case .jp:
			return cn != 0
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
	
	// Для отображения части значения в степени нужно разделить пробелом значение
	// и то, что возводится в степень
	static let allSizes: [Self] = [
		.init(diameter: 14.0, iso: 44.00, us: "3", uk: "F", cn: 4),
		.init(diameter: 14.2, iso: 45.00, us: "3 1/2", uk: "G", cn: 5),
		.init(diameter: 14.4, iso: 45.75, us: "3 5/8", uk: "G 1/2", cn: 6),
		.init(diameter: 14.6, iso: 46.00, us: "3 3/4", uk: "H", cn: 7),
		.init(diameter: 14.8, iso: 47.00, us: "4 1/4", uk: "I", cn: 8),
		
		.init(diameter: 15.0, iso: 47.75, us: "4 3/8", uk: "J", cn: 9),
		.init(diameter: 15.2, iso: 48.00, us: "4 1/2", uk: "J 1/2", cn: 10),
		.init(diameter: 15.4, iso: 49.00, us: "5", uk: "K", cn: 11),
		.init(diameter: 15.6, iso: 49.75, us: "5 1/8", uk: "K 1/2", cn: 12),
		.init(diameter: 15.8, iso: 50.00, us: "5 1/4", uk: "L", cn: 13),
		
		.init(diameter: 16.0, iso: 50.50, us: "5 1/2", uk: "L 1/2", cn: 14),
		.init(diameter: 16.2, iso: 51.50, us: "6", uk: "M", cn: 15),
		.init(diameter: 16.4, iso: 52.00, us: "6 1/4", uk: "M 1/2", cn: 16),
		.init(diameter: 16.6, iso: 52.75, us: "6 3/8", uk: "N", cn: 17),
		.init(diameter: 16.8, iso: 53.50, us: "6 1/2", uk: "N 1/2", cn: 18),
		
		.init(diameter: 17.0, iso: 54.00, us: "7", uk: "O", cn: 19),
		.init(diameter: 17.2, iso: 54.75, us: "7 1/8", uk: "O 1/2", cn: 20),
		.init(diameter: 17.4, iso: 55.50, us: "7 1/4", uk: "P", cn: 21),
		.init(diameter: 17.6, iso: 56.25, us: "7 3/8", uk: "P 1/2", cn: 22),
		.init(diameter: 17.8, iso: 57.00, us: "7 1/2", uk: "Q", cn: 23),
		
		.init(diameter: 18.0, iso: 57.50, us: "8", uk: "Q 1/2", cn: 24),
		.init(diameter: 18.2, iso: 58.50, us: "8 1/8", uk: "R", cn: 25),
		.init(diameter: 18.4, iso: 59.00, us: "8 1/4", uk: "R 1/2", cn: 26),
		.init(diameter: 18.6, iso: 59.75, us: "8 3/8", uk: "S", cn: 27),
		.init(diameter: 18.8, iso: 60.50, us: "8 1/2", uk: "S 1/2", cn: 28),
		
		.init(diameter: 19.0, iso: 61.00, us: "9", uk: "T", cn: 29),
		.init(diameter: 19.2, iso: 61.50, us: "9 1/8", uk: "T 1/2", cn: 30),
		.init(diameter: 19.4, iso: 62.50, us: "9 1/4", uk: "U", cn: 31),
		.init(diameter: 19.6, iso: 63.00, us: "9 1/2", uk: "U 1/2", cn: 32),
		.init(diameter: 19.8, iso: 63.75, us: "9 5/8", uk: "V", cn: 33),
		
		.init(diameter: 20.0, iso: 64.25, us: "9 3/4", uk: "V 1/2", cn: 34),
		.init(diameter: 20.2, iso: 65.25, us: "10 1/4", uk: "W", cn: 35),
		.init(diameter: 20.4, iso: 65.75, us: "10 3/8", uk: "W 1/2", cn: 36),
		.init(diameter: 20.6, iso: 66.50, us: "10 1/2", uk: "X", cn: 37),
		.init(diameter: 20.8, iso: 67.00, us: "11", uk: "X 1/2", cn: 38),
		
		.init(diameter: 21.0, iso: 67.75, us: "11 1/4", uk: "Y", cn: 39),
		.init(diameter: 21.2, iso: 68.50, us: "11 3/8", uk: "Y 1/2", cn: 40),
		.init(diameter: 21.4, iso: 69.25, us: "11 1/2", uk: "Z", cn: 41),
		.init(diameter: 21.6, iso: 70.00, us: "11 5/8", uk: "Z 1/2", cn: 42),
		.init(diameter: 21.8, iso: 70.25, us: "12", uk: "Z+1", cn: 43),
		
		.init(diameter: 22.0, iso: 70.75, us: "12 1/8", uk: "Z+1 1/2", cn: 44),
		.init(diameter: 22.2, iso: 71.50, us: "12 1/4", uk: "Z+2", cn: 45),
		.init(diameter: 22.4, iso: 72.25, us: "12 3/8", uk: "Z+2 1/2", cn: 46),
		.init(diameter: 22.6, iso: 73.00, us: "12 1/2", uk: "Z+3", cn: 47),
		.init(diameter: 22.8, iso: 73.75, us: "12 5/8", uk: "Z+3 1/2", cn: 48),
		
		.init(diameter: 23.0, iso: 74.50, us: "13", uk: "Z+4", cn: 49),
		.init(diameter: 23.2, iso: 75.25, us: "13 1/8", uk: "Z+4 1/2", cn: 50),
		.init(diameter: 23.4, iso: 76.00, us: "13 1/4", uk: "Z+5", cn: 51)
	]
}
