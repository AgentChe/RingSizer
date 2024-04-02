//
//  SavedSizesAction.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 02.04.2024.
//

import Foundation
import UIKit

enum SavedSizesAction: CaseIterable {
	case share
	case convert
	case delete
}

extension SavedSizesAction {
	var name: String {
		switch self {
		case .share:
			return "SavedSizesActions.Share".localized
		case .convert:
			return "SavedSizesActions.Convert".localized
		case .delete:
			return "SavedSizesActions.Delete".localized
		}
	}
	
	var icon: UIImage? {
		switch self {
		case .share:
			return UIImage(named: "SavedSizesActions.Share")
		case .convert:
			return UIImage(named: "SavedSizesActions.Convert")
		case .delete:
			return UIImage(named: "SavedSizesActions.Delete")
		}
	}
}
