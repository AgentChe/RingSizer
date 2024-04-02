//
//  FingerSizerConverterView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 30.03.2024.
//

import UIKit

class FingerSizerConverterView: UIView {
	
	lazy var headerView = makeHeaderView()
	lazy var subtitle = makeSubtitle()
	lazy var sizeLabel = makeConvertedSize()
	lazy var dropdown = makeDropdown()
	lazy var primaryButton = makePrimaryButton()
	lazy var backButton = makeBackButton()
	
	private lazy var containerView = makeContainer()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = Appearance.v4WarmBeige
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Make constraints
private extension FingerSizerConverterView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			backButton.heightAnchor.constraint(equalToConstant: 24.scale),
			backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor),
			backButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 80.scale : 26.scale),
			headerView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 3.scale),
			headerView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			subtitle.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 22.scale),
			subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
		])
		
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 102.scale),
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 71.scale),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -71.scale)
		])
		
		NSLayoutConstraint.activate([
			sizeLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
			sizeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			sizeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			dropdown.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 60.scale),
			dropdown.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 63.scale),
			dropdown.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -63.scale)
		])
		
		NSLayoutConstraint.activate([
			primaryButton.topAnchor.constraint(equalTo: dropdown.bottomAnchor, constant: 60.scale),
			primaryButton.heightAnchor.constraint(equalToConstant: 54.scale),
			primaryButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			primaryButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			primaryButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension FingerSizerConverterView {
	func makeHeaderView() -> HeaderView {
		let view = HeaderView(title: "FingerSizerConverter.Title".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.button.isHidden = true
		addSubview(view)
		return view
	}
	
	func makeSubtitle() -> UILabel {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.4.scale)
			.textAlignment(.center)
		
		let view = UILabel()
		view.attributedText = "FingerSizerConverter.Subtitle".localized.attributed(with: attrs)
		view.numberOfLines = 0
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeContainer() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		addSubview(view)
		return view
	}
	
	func makeConvertedSize() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeDropdown() -> ConverterDropdownView {
		let view = ConverterDropdownView()
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makePrimaryButton() -> PrimaryButton {
		let view = PrimaryButton(title: "FingerSizerConverter.Save".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeBackButton() -> TapAreaButton {
		let view = TapAreaButton()
		view.setImage(UIImage(named: "FingerSizer.Back"), for: .normal)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}
