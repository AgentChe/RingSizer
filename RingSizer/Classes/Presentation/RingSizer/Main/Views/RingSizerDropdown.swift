//
//  RingSizerDropdown.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 27.03.2024.
//

import UIKit

class RingSizerDropdown: UIButton {
	
	private lazy var labelView = makeLabel()
	private lazy var indicator = makeIndicator()

	var title: String = "" {
		didSet {
			labelView.attributedText = title.attributed(with: RingSizerDropdown.textAttrs)
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


// MARK: Make constraints
private extension RingSizerDropdown {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			labelView.topAnchor.constraint(equalTo: topAnchor, constant: 8.scale),
			labelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.scale),
			labelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.scale)
		])
		
		NSLayoutConstraint.activate([
			indicator.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
			indicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.scale),
			indicator.leadingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: 5.scale),
			indicator.heightAnchor.constraint(equalToConstant: 24.scale),
			indicator.widthAnchor.constraint(equalToConstant: 24.scale)
		])
	}
}

// MARK: Lazy initialization
private extension RingSizerDropdown {
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

private extension RingSizerDropdown {
	static let textAttrs = TextAttributes()
		.textColor(Appearance.v4DarkGrey)
		.font(Fonts.Sen.regular(size: 16.scale))
		.lineHeight(26.scale)
		.textAlignment(.right)
}
