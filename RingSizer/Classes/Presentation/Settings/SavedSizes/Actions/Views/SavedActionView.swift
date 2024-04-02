//
//  SavedActionView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 02.04.2024.
//

import UIKit

class SavedActionView: UIButton {
	
	private lazy var labelView = makeLabel()
	private lazy var icon = makeImageView()
	private lazy var bottomLine = makeLineView()
	
	var isHideSeparator: Bool = false {
		didSet {
			bottomLine.isHidden = isHideSeparator
		}
	}
	
	let action: SavedSizesAction

	init(action: SavedSizesAction) {
		self.action = action
		super.init(frame: .zero)
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.4.scale)
			.textAlignment(.left)
		
		labelView.attributedText = action.name.attributed(with: attrs)
		icon.image = action.icon
		backgroundColor = Appearance.v4White
		bottomLine.isHidden = isHideSeparator
		
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Make constraints
private extension SavedActionView {
	func makeConstraints() {
		
		NSLayoutConstraint.activate([
			labelView.topAnchor.constraint(equalTo: topAnchor, constant: 17.scale),
			labelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17.scale),
			labelView.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 17.scale),
			labelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -23.scale)
		])
		
		NSLayoutConstraint.activate([
			icon.heightAnchor.constraint(equalToConstant: 24.scale),
			icon.widthAnchor.constraint(equalTo: icon.heightAnchor),
			icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 23.scale),
			icon.centerYAnchor.constraint(equalTo: labelView.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			bottomLine.heightAnchor.constraint(equalToConstant: 1.scale),
			bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
			bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
			bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension SavedActionView {
	func makeLabel() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeImageView() -> UIImageView {
		let view = UIImageView()
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
