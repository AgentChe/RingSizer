//
//  UIDeviceModel.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 31.03.2024.
//

import Foundation
import UIKit


enum UIDeviceModel {
	case iPhoneSE
	case iPhone6Plus
	case iPhone6s
	case iPhone6sPlus
	case iPhone7
	case iPhone7Plus
	case iPhone8
	case iPhone8Plus
	case iPhoneX
	case iPhoneXS
	case iPhoneXSMax
	case iPhoneXR
	case iPhone11
	case iPhone11Pro
	case iPhone11ProMax
	case iPhoneSEGen2
	case iPhone12mini
	case iPhone12
	case iPhone12Pro
	case iPhone12ProMax
	case iPhone13
	case iPhone13Mini
	case iPhone13Pro
	case iPhone13ProMax
	case iPhoneSEGen3
	case iPhone14
	case iPhone14Plus
	case iPhone14Pro
	case iPhone14ProMax
	case iPhone15
	case iPhone15Plus
	case iPhone15Pro
	case iPhone15ProMax

	indirect case simulator(UIDeviceModel)

	case unknown(String)
}

extension UIDeviceModel {
	var unwrapIfSimulator: UIDeviceModel {
		return UIDeviceModel.unwrapIfSimulator(self)
	}

	private static func unwrapIfSimulator(_ device: UIDeviceModel) -> UIDeviceModel {
		if case let .simulator(model) = device {
			return model
		}
		return device
	}
}

extension UIDeviceModel {
	static var current: UIDeviceModel {
		return mapToDevice(identifier: identifier)
	}

	private static var identifier: String = {
		var systemInfo = utsname()
		uname(&systemInfo)
		let mirror = Mirror(reflecting: systemInfo.machine)
		let identifier = mirror.children.reduce("") { identifier, element in
			guard let value = element.value as? Int8, value != 0 else { return identifier }
			return identifier + String(UnicodeScalar(UInt8(value)))
		}
		return identifier
	}()

	private static func mapToDevice(identifier: String) -> UIDeviceModel {
		switch identifier {
		case "iPhone7,1": return .iPhone6Plus
		case "iPhone8,1": return .iPhone6s
		case "iPhone8,2": return .iPhone6sPlus
		case "iPhone8,4": return .iPhoneSE
		case "iPhone9,1", "iPhone9,3": return .iPhone7
		case "iPhone9,2", "iPhone9,4": return .iPhone7Plus
		case "iPhone10,1", "iPhone10,4": return .iPhone8
		case "iPhone10,2", "iPhone10,5": return .iPhone8Plus
		case "iPhone10,3", "iPhone10,6": return .iPhoneX
		case "iPhone11,2": return .iPhoneXS
		case "iPhone11,4", "iPhone11,6": return .iPhoneXSMax
		case "iPhone11,8": return .iPhoneXR
		case "iPhone12,1": return .iPhone11
		case "iPhone12,3": return .iPhone11Pro
		case "iPhone12,5": return .iPhone11ProMax
		case "iPhone12,8": return .iPhoneSEGen2
		case "iPhone13,1": return .iPhone12mini
		case "iPhone13,2": return .iPhone12
		case "iPhone13,3": return .iPhone12Pro
		case "iPhone13,4": return .iPhone12ProMax
		case "iPhone14,5": return .iPhone13
		case "iPhone14,4": return .iPhone13Mini
		case "iPhone14,2": return .iPhone13Pro
		case "iPhone14,3": return .iPhone13ProMax
		case "iPhone14,6": return .iPhoneSEGen3
		case "iPhone14,7": return .iPhone14
		case "iPhone14,8": return .iPhone14Plus
		case "iPhone15,2": return .iPhone14Pro
		case "iPhone15,3": return .iPhone14ProMax
		case "iPhone15,4": return .iPhone15
		case "iPhone15,5": return .iPhone15Plus
		case "iPhone16,1": return .iPhone15Pro
		case "iPhone16,2": return .iPhone15ProMax
		case "i386", "x86_64", "arm64": return .simulator(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))
		default: return .unknown(identifier)
		}
	}
}

extension UIDeviceModel {
	static var displayInch: CGFloat {
		let device = current.unwrapIfSimulator
		
		switch device {
		case .iPhoneSE:
			return 4
		case .iPhoneSEGen2, .iPhoneSEGen3, .iPhone7, .iPhone8, .iPhone6s:
			return 4.7
		case .iPhone12mini, .iPhone13Mini:
			return 5.42
		case .iPhone7Plus, .iPhone8Plus, .iPhone6Plus, .iPhone6sPlus:
			return 5.5
		case .iPhoneX, .iPhoneXS, .iPhone11Pro:
			return 5.85
		case .iPhoneXR, .iPhone13, .iPhone13Pro, .iPhone12, .iPhone12Pro:
			return 6.06
		case .iPhone11, .iPhone14, .iPhone14Pro, .iPhone15, .iPhone15Pro:
			return 6.1
		case .iPhoneXSMax, .iPhone11ProMax:
			return 6.46
		case .iPhone12ProMax, .iPhone13ProMax:
			return 6.68
		case .iPhone14Plus, .iPhone14ProMax, .iPhone15Plus, .iPhone15ProMax:
			return 6.7
		case .simulator, .unknown:
            return 4.7
		}
	}
	
	var scaleFactor: CGFloat {
		UIDeviceModel.displayInch * 25.4 / sqrt(pow(UIScreen.main.bounds.width, 2) + pow(UIScreen.main.bounds.height, 2))
	}
}
