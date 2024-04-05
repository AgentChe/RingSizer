//
//  FingerSizerOnboardingView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 30.03.2024.
//

import UIKit

class FingerSizerOnboardingView: UIView {

	lazy var headerView = makeHeaderView()
	lazy var subtitle = makeSubtitle()
	lazy var primaryButton = makePrimaryButton()
	lazy var fingerView = makeFingerView()
	
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
private extension FingerSizerOnboardingView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 80.scale : 26.scale),
			headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			subtitle.topAnchor.constraint(equalTo: headerView.bottomAnchor),
			subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
		])
		
		NSLayoutConstraint.activate([
			primaryButton.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 40.scale),
			primaryButton.heightAnchor.constraint(equalToConstant: 54.scale),
			primaryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 71.scale),
			primaryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -71.scale)
		])
		
		NSLayoutConstraint.activate([
			fingerView.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: 49.scale),
			fingerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 95.scale),
			fingerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -95.scale),
			fingerView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension FingerSizerOnboardingView {
	func makeHeaderView() -> HeaderView {
		let view = HeaderView(title: "FingerSizerOnboadring.Title".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
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
		view.attributedText = "FingerSizerOnboadring.Subtitle".localized.attributed(with: attrs)
		view.numberOfLines = 0
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makePrimaryButton() -> PrimaryButton {
		let view = PrimaryButton(title: "FingerSizerOnboadring.Start".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeFingerView() -> FingerView {
		let view = FingerView()
		view.layer.borderWidth = 1
		view.layer.borderColor = Appearance.v4Grey.cgColor
		view.backgroundColor = Appearance.v4White
		view.fingerColor = Appearance.v4White
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}
