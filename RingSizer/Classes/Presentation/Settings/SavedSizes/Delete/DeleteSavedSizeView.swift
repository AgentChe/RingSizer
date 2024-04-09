//
//  DeleteSavedSizeView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 01.04.2024.
//

import UIKit

class DeleteSavedSizeView: UIView {
	
	lazy var containerView = makeContainerView()
	lazy var titleView = makeTitleView()
	lazy var subtitleView = makeSubtitleView()
	lazy var closeButton = makeCloseButton()
	lazy var primaryButton = makePrimaryButton()
	lazy var secondaryButton = makeSecondaryButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Make constraints
private extension DeleteSavedSizeView {
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
			subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 54.scale),
			subtitleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 42.scale),
			subtitleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -42.scale)
		])
		
		NSLayoutConstraint.activate([
			primaryButton.topAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: 31.scale),
			primaryButton.heightAnchor.constraint(equalToConstant: 54.scale),
			primaryButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 66.scale),
			primaryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -66.scale)
		])
		
		NSLayoutConstraint.activate([
			secondaryButton.topAnchor.constraint(equalTo: primaryButton.bottomAnchor),
			secondaryButton.heightAnchor.constraint(equalToConstant: 54.scale),
			secondaryButton.leadingAnchor.constraint(equalTo: primaryButton.leadingAnchor),
			secondaryButton.trailingAnchor.constraint(equalTo: primaryButton.trailingAnchor),
			secondaryButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:  -40.scale)
		])
	}
}

// MARK: Lazy initialization
private extension DeleteSavedSizeView {
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
		view.attributedText = "Delete.Title".localized.attributed(with: attrs)
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
		view.attributedText = "Delete.Subtitle".localized.attributed(with: attrs)
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
	
	func makePrimaryButton() -> PrimaryButton {
		let view = PrimaryButton(title: "Delete.Delete".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeSecondaryButton() -> UIButton {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.4.scale)
			.textAlignment(.center)
		
		let view = UIButton()
		view.setAttributedTitle("Delete.Cancel".localized.attributed(with: attrs), for: .normal)
		view.backgroundColor = Appearance.v4White
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
}
