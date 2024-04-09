//
//  ExpandableHeaderViewCell.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 28.03.2024.
//

import UIKit

class ExpandableHeaderViewCell: UICollectionViewListCell {
	lazy var titleView = makeLabelView()
	lazy var iconView = makeIconView()
	lazy var separator = makeSeparator()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = Appearance.v4White
		contentView.backgroundColor = Appearance.v4White
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func updateConfiguration(using state: UICellConfigurationState) {
		super.updateConfiguration(using: state)
		iconView.transform = state.isExpanded ? .identity : CGAffineTransform(rotationAngle: .pi)
	}
	
	func setup(title: String) {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.4.scale)
			.textAlignment(.left)
		
		titleView.attributedText = title.attributed(with: attrs)
	}
}

// MARK: Lazy initialization
private extension ExpandableHeaderViewCell {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11.scale),
			titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.scale)
		])
		
		NSLayoutConstraint.activate([
			iconView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
			iconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.scale),
			iconView.heightAnchor.constraint(equalToConstant: 24.scale),
			iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),
			iconView.leadingAnchor.constraint(lessThanOrEqualTo: titleView.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			separator.heightAnchor.constraint(equalToConstant: 6.scale),
			separator.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 11.scale),
			separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension ExpandableHeaderViewCell {
	func makeLabelView() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(view)
		return view
	}
	
	func makeIconView() -> UIImageView {
		let view = UIImageView()
		view.image = UIImage(named: "SaveSize.Chevron")
		view.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(view)
		return view
	}
	
	func makeSeparator() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Appearance.v4WarmBeige
		contentView.addSubview(view)
		return view
	}
}
