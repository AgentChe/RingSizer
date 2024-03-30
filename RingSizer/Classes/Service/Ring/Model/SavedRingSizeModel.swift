//
//  SavedRingSizeModel.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 28.03.2024.
//

import Foundation

struct SavedRingSizeModel: Equatable, Codable {
	let id: String
	let name: String
	let hand: Hand
	let finger: Finger
	let ringSize: RingSize
	let measureSystem: MeasurementSystem
	
	init(name: String, hand: Hand, finger: Finger, ringSize: RingSize, measureSystem: MeasurementSystem) {
		self.id = UUID().uuidString
		self.name = name
		self.hand = hand
		self.finger = finger
		self.ringSize = ringSize
		self.measureSystem = measureSystem
	}
}

enum Hand: String, CaseIterable, Codable {
	case left
	case right
	
	var name: String {
		switch self {
		case .left:
			"SaveSize.LeftHand".localized
		case .right:
			"SaveSize.RightHand".localized
		}
	}
}

enum Finger: String, CaseIterable, Codable {
	case thumb
	case index
	case middle
	case ring
	case pinky
	
	var name: String {
		switch self {
		case .thumb:
			return "SaveSize.Thumb".localized
		case .index:
			return "SaveSize.IndexFinger".localized
		case .middle:
			return "SaveSize.MiddleFinger".localized
		case .ring:
			return "SaveSize.RingFinger".localized
		case .pinky:
			return "SaveSize.Pinky".localized
		}
	}
}
