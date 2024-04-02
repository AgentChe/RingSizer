//
//  SavedActionsPresentationController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 03.04.2024.
//

import UIKit

class SavedActionsPresentationController: DimmedPresentationController {
	override var frameOfPresentedViewInContainerView: CGRect {
		if let bounds = containerView?.bounds {
			let height = 209.scale
			return CGRect(
				x: 0,
				y: bounds.height - height,
				width: bounds.width,
				height: height
			)
		} else {
			return super.frameOfPresentedViewInContainerView
		}
	}
}
