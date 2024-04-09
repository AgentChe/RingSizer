//
//  VerticalSlider.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 03.04.2024.
//

import UIKit

class VerticalSlider: UIView {

	let slider = RingSlider()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		slider.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
		addSubview(slider)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		slider.bounds.size.width = bounds.height
		slider.center.x = bounds.midX
		slider.center.y = bounds.midY
	}
	
	override var intrinsicContentSize: CGSize {
		get {
			CGSize(width: slider.intrinsicContentSize.height, height: slider.intrinsicContentSize.width)
		}
	}
}
