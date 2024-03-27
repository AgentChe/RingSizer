//
//  DropdownView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 25.03.2024.
//

import UIKit

class DropdownView: UIButton {
	
	private lazy var labelView = makeLabel()
	private lazy var indicator = makeIndicator()
	private lazy var bottomLine = makeLineView()

	var title: String = "" {
		didSet {
			labelView.attributedText = title.attributed(with: DropdownView.textAttrs)
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
private extension DropdownView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			labelView.topAnchor.constraint(equalTo: topAnchor),
			labelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.scale)
		])
		
		NSLayoutConstraint.activate([
			indicator.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
			indicator.trailingAnchor.constraint(equalTo: trailingAnchor),
			indicator.leadingAnchor.constraint(greaterThanOrEqualTo: labelView.leadingAnchor),
			indicator.heightAnchor.constraint(equalToConstant: 24.scale),
			indicator.widthAnchor.constraint(equalToConstant: 24.scale)
		])
		
		NSLayoutConstraint.activate([
			bottomLine.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 10.scale),
			bottomLine.heightAnchor.constraint(equalToConstant: 1.scale),
			bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
			bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
			bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension DropdownView {
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
	
	func makeLineView() -> UIView {
		let view = UIView()
		view.backgroundColor = Appearance.v4Grey
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}

private extension DropdownView {
	static let textAttrs = TextAttributes()
		.textColor(Appearance.v4DarkGrey)
		.font(Fonts.Sen.regular(size: 20.scale))
		.lineHeight(26.scale)
		.textAlignment(.left)
}
