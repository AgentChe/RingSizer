//
//  RingSlider.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 27.03.2024.
//

import UIKit

class RingSlider: UISlider {
	
	override func trackRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(origin: bounds.origin, size: .init(width: bounds.width, height: 1.scale))
	}
}

