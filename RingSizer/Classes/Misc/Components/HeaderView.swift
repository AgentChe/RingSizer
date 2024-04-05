//
//  HeaderView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 25.03.2024.
//

import UIKit

class HeaderView: UIView {
	
	lazy var button = makeButton()
	private lazy var titleView = makeTitleView()
	
	private let title: String
	
	init(title: String) {
		self.title = title
		super.init(frame: .zero)
		titleView.setContentHuggingPriority(.defaultHigh, for: .vertical)
		backgroundColor = Appearance.v4WarmBeige
		
		makeConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Make constraints
private extension HeaderView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			titleView.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale),
			titleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.scale),
			titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale)
		])
		
		NSLayoutConstraint.activate([
			button.heightAnchor.constraint(equalToConstant: 24.scale),
			button.widthAnchor.constraint(equalTo: button.heightAnchor),
			button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
			button.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
			button.leadingAnchor.constraint(lessThanOrEqualTo: titleView.trailingAnchor, constant: 16.scale)
		])
	}
}

// MARK: Lazy initialization
private extension HeaderView {
	func makeTitleView() -> UILabel {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.bold(size: 24))
			.lineHeight(30)
			.textAlignment(.left)
		
		let view = UILabel()
		view.attributedText = title.attributed(with: attrs)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeButton() -> TapAreaButton {
		let view = TapAreaButton()
		view.setImage(UIImage(named: "Burger"), for: .normal)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}
