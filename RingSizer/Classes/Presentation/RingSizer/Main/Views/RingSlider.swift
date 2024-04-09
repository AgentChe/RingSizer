//
//  RingSlider.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 27.03.2024.
//

import UIKit

class RingSlider: UISlider {
	
	override func trackRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(
			origin: .init(x: bounds.origin.x, y: bounds.midY - 0.5.scale),
			size: .init(width: bounds.width, height: 1.scale)
		)
	}
}

