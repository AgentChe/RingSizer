//
//  ConverterSizeButton.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 26.03.2024.
//

import UIKit

class ConverterSizeButton: UIButton {
	
	private lazy var labelView = makeLabel()
	private lazy var indicator = makeIndicator()
	
	var title: String? = nil {
		didSet {
			if let title {
				labelView.attributedText = title.attributed(with: ConverterSizeButton.valueAttrs)
			} else {
				labelView.attributedText = "Converter.RingSize".localized.attributed(with: ConverterSizeButton.emptyAttrs)
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Private
private extension ConverterSizeButton {
	func initialize() {
		layer.borderWidth = 1.scale
		layer.borderColor = Appearance.v4Grey.cgColor
		backgroundColor = Appearance.v4WarmBeige
	}
}

// MARK: Make constraints
private extension ConverterSizeButton {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			labelView.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale),
			labelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.scale),
			labelView.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			indicator.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
			indicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
			indicator.heightAnchor.constraint(equalToConstant: 24.scale),
			indicator.widthAnchor.constraint(equalToConstant: 24.scale)
		])
	}
}

// MARK: Lazy initialization
private extension ConverterSizeButton {
	func makeLabel() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeIndicator() -> UIImageView {
		let view = UIImageView(image: UIImage(named: "DropdownIndicator"))
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}

private extension ConverterSizeButton {
	static let emptyAttrs = TextAttributes()
		.textColor(Appearance.v4DarkGrey.withAlphaComponent(0.6))
		.font(Fonts.Sen.regular(size: 16.scale))
		.lineHeight(22.4.scale)
		.textAlignment(.center)
	
	static let valueAttrs = TextAttributes()
		.textColor(Appearance.v4DarkGrey)
		.font(Fonts.Sen.regular(size: 58.scale))
		.textAlignment(.center)
}
