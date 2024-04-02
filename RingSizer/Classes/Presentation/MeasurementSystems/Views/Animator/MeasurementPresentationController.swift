//
//  MeasurementPresentationController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 02.04.2024.
//

import UIKit

class MeasurementPresentationController: DimmedPresentationController {
	
	override var frameOfPresentedViewInContainerView: CGRect {
		if let bounds = containerView?.bounds {
			let height = 318.scale
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
