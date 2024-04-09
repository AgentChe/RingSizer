//
//  HelpView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 29.03.2024.
//

import UIKit

class HelpView: UIView {
	lazy var containerView = makeContainerView()
	lazy var titleView = makeTitleView()
	lazy var imageView = makeImageView()
	lazy var subtitleView = makeSubtitleView()
	lazy var closeButton = makeCloseButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Make constraints
private extension HelpView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
		])
		
		NSLayoutConstraint.activate([
			titleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20.scale),
			titleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 31.scale)
		])
		
		NSLayoutConstraint.activate([
			closeButton.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
			closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20.scale),
			closeButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleView.trailingAnchor, constant: 20.scale),
			closeButton.heightAnchor.constraint(equalToConstant: 24.scale),
			closeButton.widthAnchor.constraint(equalTo: closeButton.heightAnchor)
		])
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 40.scale),
			imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			subtitleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 28.scale),
			subtitleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 42.scale),
			subtitleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -42.scale),
			subtitleView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -48.scale)
		])
	}
}

// MARK: Lazy initialization
private extension HelpView {
	func makeContainerView() -> UIView {
		let view = UIView()
		view.backgroundColor = Appearance.v4White
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeTitleView() -> UILabel {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.bold(size: 20.scale))
			.lineHeight(22.scale)
			.textAlignment(.left)
		
		
		let view = UILabel()
		view.attributedText = "Help.Title".localized.attributed(with: attrs)
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeImageView() -> UIImageView {
		let view = UIImageView(image: UIImage(named: "Help.HelpImage"))
		view.contentMode = .scaleAspectFit
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeSubtitleView() -> UILabel {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.scale)
			.textAlignment(.center)
		
		let view = UILabel()
		view.numberOfLines = 0
		view.attributedText = "Help.Subtitle".localized.attributed(with: attrs)
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeCloseButton() -> UIButton {
		let view = UIButton()
		view.setImage(UIImage(named: "Paygate.Close"), for: .normal)
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
}
