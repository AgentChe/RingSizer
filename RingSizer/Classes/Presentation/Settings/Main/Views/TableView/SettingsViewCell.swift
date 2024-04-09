//
//  SettingsViewCell.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 02.04.2024.
//

import UIKit

class SettingsViewCell: UITableViewCell {
	
	lazy var titleView = makeTitleLabel()
	private lazy var separatorView = makeSeparator()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initialize()
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Public
extension SettingsViewCell {
	func setup(title: String, isHideLine: Bool) {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.4.scale)
			.textAlignment(.left)
		
		separatorView.isHidden = isHideLine
		
		titleView.attributedText = title.attributed(with: attrs)
	}
}

// MARK: Private
private extension SettingsViewCell {
	func initialize() {
		backgroundColor = .clear
		contentView.backgroundColor = .clear
		selectionStyle = .none
	}
}

// MARK: Make constraints
private extension SettingsViewCell {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.scale),
			titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24.scale),
			titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
			titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale)
		])
		
		NSLayoutConstraint.activate([
			separatorView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
			separatorView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
			separatorView.heightAnchor.constraint(equalToConstant: 0.3.scale),
			separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension SettingsViewCell {
	func makeTitleLabel() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(view)
		return view
	}
	
	func makeSeparator() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Appearance.v4Grey.withAlphaComponent(0.3)
		contentView.addSubview(view)
		return view
	}
}
