//
//  MeasurementSystemViewCell.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 26.03.2024.
//

import UIKit

class MeasurementSystemViewCell: UITableViewCell {

	lazy var titleView = makeLabelView()
	lazy var iconView = makeIconView()
	lazy var separator = makeSeparator()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initialize()
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		let image = selected ? UIImage(named: "RadioButton.Selected") : UIImage(named: "RadioButton.Default")
		iconView.image = image
	}
}

// MARK: Public
extension MeasurementSystemViewCell {
	func setup(type: MeasurementSystem, isHiddedSeparator: Bool) {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.4.scale)
			.textAlignment(.left)
		
		titleView.attributedText = type.description.attributed(with: attrs)
		separator.isHidden = isHiddedSeparator
	}
}

// MARK: Private
private extension MeasurementSystemViewCell {
	func initialize() {
		backgroundColor = UIColor.clear
		contentView.backgroundColor = UIColor.clear
		
		selectionStyle = .none
	}
}

// MARK: Make constraints
private extension MeasurementSystemViewCell {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17.scale),
			titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17.scale),
			titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
		])
		
		NSLayoutConstraint.activate([
			iconView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
			iconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			iconView.heightAnchor.constraint(equalToConstant: 24.scale),
			iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor),
			iconView.leadingAnchor.constraint(lessThanOrEqualTo: titleView.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			separator.heightAnchor.constraint(equalToConstant: 1.scale),
			separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension MeasurementSystemViewCell {
	func makeLabelView() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(view)
		return view
	}
	
	func makeIconView() -> UIImageView {
		let view = UIImageView()
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
