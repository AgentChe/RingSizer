//
//  RingView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 27.03.2024.
//

import UIKit

class RingView: UIView {
	
	private lazy var labelView = makeLabel()
	
	var currentSize: RingSize = .allSizes.first! {
		didSet {
			let text = "\(currentSize.diameter) \("RingSize.MM".localized)"
			labelView.attributedText = text.attributed(with: RingView.attrs)
			setNeedsDisplay()
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		makeConstraints()
		backgroundColor = Appearance.v4WarmBeige
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func draw(_ rect: CGRect) {
		let radius = (currentSize.diameter / 2) / UIDeviceModel.current.scaleFactor
		let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
		let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
		path.stroke()
		
		let circleLayer = CAShapeLayer()
		circleLayer.backgroundColor = UIColor.clear.cgColor
		circleLayer.path = path.cgPath
		layer.mask = circleLayer
	}
}

// MARK: Make constraints
private extension RingView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			labelView.centerXAnchor.constraint(equalTo: centerXAnchor),
			labelView.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension RingView {
	func makeLabel() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}

private extension RingView {
	static let attrs = TextAttributes()
		.textColor(Appearance.v4DarkGrey)
		.font(Fonts.Sen.regular(size: 14.scale))
		.lineHeight(22.scale)
		.textAlignment(.center)
}
