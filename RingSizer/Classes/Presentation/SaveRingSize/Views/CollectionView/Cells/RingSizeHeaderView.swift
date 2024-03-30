//
//  RingSizeHeaderView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 28.03.2024.
//

import UIKit

class RingSizeHeaderView: UICollectionReusableView {
	static var reuseIdentifier: String {
		return String(describing: RingSizeHeaderView.self)
	  }
	
	private lazy var titleView = makeTitleView()
	override init(frame: CGRect) {
		super.init(frame: frame)
		makeConstraints()
		backgroundColor = .clear
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setup(title: String) {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.bold(size: 16.scale))
			.lineHeight(26.scale)
			.textAlignment(.left)
		
		titleView.attributedText = title.attributed(with: attrs)
	}
}

// MARK: Make constraints
private extension RingSizeHeaderView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
			titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
			titleView.topAnchor.constraint(equalTo: topAnchor, constant: 10.scale),
			titleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15.scale)
		])
	}
}

// MARK: Lazy initialization
private extension RingSizeHeaderView {
	func makeTitleView() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}
