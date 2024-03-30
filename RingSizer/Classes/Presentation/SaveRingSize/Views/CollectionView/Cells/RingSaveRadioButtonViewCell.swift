//
//  RingSaveRadioButtonViewCell.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 28.03.2024.
//

import UIKit

class RingSaveRadioButtonViewCell: UICollectionViewCell {

	lazy var titleView = makeLabelView()
	lazy var iconView = makeIconView()
	lazy var separator = makeSeparator()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func updateConfiguration(using state: UICellConfigurationState) {
		let image = state.isSelected ? UIImage(named: "RadioButton.Selected") : UIImage(named: "RadioButton.Default")
		iconView.image = image
	}
}

// MARK: Public
extension RingSaveRadioButtonViewCell {
	func setup(title: String, isLast: Bool) {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.4.scale)
			.textAlignment(.left)
		
		titleView.attributedText = title.attributed(with: attrs)
		separator.isHidden = isLast
	}
}

// MARK: Private
private extension RingSaveRadioButtonViewCell {
	func initialize() {
		backgroundColor = Appearance.v4White
		contentView.backgroundColor = Appearance.v4White
	}
}

// MARK: Make constraints
private extension RingSaveRadioButtonViewCell {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17.scale),
			titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17.scale),
			titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28.scale)
		])
		
		NSLayoutConstraint.activate([
			iconView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
			iconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28.scale),
			iconView.heightAnchor.constraint(equalToConstant: 24.scale),
			iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),
			iconView.leadingAnchor.constraint(lessThanOrEqualTo: titleView.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			separator.heightAnchor.constraint(equalToConstant: 1.scale),
			separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11.scale),
			separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -11.scale),
			separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension RingSaveRadioButtonViewCell {
	func makeLabelView() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(view)
		return view
	}
	
	func makeIconView() -> UIImageView {
		let view = UIImageView()
		view.image = UIImage(named: "RadioButton.Default")
		view.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(view)
		return view
	}
	
	func makeSeparator() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Appearance.v4Grey
		contentView.addSubview(view)
		return view
	}
}
