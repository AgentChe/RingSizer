//
//  FingerView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 30.03.2024.
//

import UIKit

class FingerView: UIView {

	var currentSize: RingSize = .allSizes.first! {
		didSet {
			setNeedsDisplay()
		}
	}
	
	var fingerColor: UIColor = Appearance.v4Yellow {
		didSet {
			setNeedsLayout()
		}
	}
	
	override func draw(_ rect: CGRect) {
		let width = currentSize.diameter / UIDeviceModel.current.scaleFactor
		let fingerRect = CGRect(
			x: (rect.width - width) / 2,
			y: rect.origin.y + 26.0,
			width: width,
			height: rect.height
		)
		let fingerRadius = fingerRect.width / 2
		
		let innerWidth = (width - width * 0.3) * (0.67 + width * 0.003)
		let innerRect = CGRect(
			x: fingerRect.midX - innerWidth / 2,
			y: fingerRect.minY + fingerRect.width / 2,
			width: innerWidth,
			height: width
		)
		let innerRadius = innerRect.width / 2
		
		
		let bezierPath = UIBezierPath()
		bezierPath.move(to: .init(x: fingerRect.maxX, y: fingerRect.minY + fingerRadius))
		bezierPath.addLine(to: .init(x: fingerRect.maxX, y: fingerRect.maxY))
		bezierPath.addLine(to: .init(x: fingerRect.minX, y: fingerRect.maxY))
		bezierPath.addLine(to: .init(x: fingerRect.minX, y: fingerRect.minY + fingerRadius))
		bezierPath.addArc(
			withCenter: .init(x: fingerRect.midX, y: fingerRect.minY + fingerRadius),
			radius: fingerRadius,
			startAngle: -.pi,
			endAngle: 0,
			clockwise: true
		)
		bezierPath.close()
		
		bezierPath.move(to: .init(x: innerRect.minX, y: innerRect.minY))
		bezierPath.addLine(to: .init(x: innerRect.minX, y: innerRect.maxY))
		bezierPath.addArc(
			withCenter: .init(x: innerRect.midX, y: innerRect.maxY),
			radius: innerRadius,
			startAngle: -.pi,
			endAngle: 0,
			clockwise: false
		)
		bezierPath.addLine(to: .init(x: innerRect.maxX, y: innerRect.minY))
		bezierPath.addArc(
			withCenter: .init(x: innerRect.midX, y: innerRect.minY),
			radius: innerRadius,
			startAngle: 0,
			endAngle: -.pi,
			clockwise: false
		)
		bezierPath.close()
		
		fingerColor.setFill()
		bezierPath.fill()
		Appearance.v4DarkGrey.setStroke()
		bezierPath.lineWidth = 1
		bezierPath.stroke()	}
}
