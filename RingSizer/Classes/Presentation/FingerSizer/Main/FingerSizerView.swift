//
//  FingerSizerView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 30.03.2024.
//

import UIKit

class FingerSizerView: UIView {

	lazy var headerView = makeHeaderView()
	lazy var subtitle = makeSubtitle()
	lazy var primaryButton = makePrimaryButton()
	lazy var backButton = makeBackButton()
	lazy var fingerView = makeFingerView()
	lazy var sliderView = makeSliderView()
	lazy var rightHandButton = makeChangeHandButton()
	lazy var leftHandButton = makeChangeHandButton()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = Appearance.v4WarmBeige
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func changeHand(hand: Hand) {
		switch hand {
		case .left:
			leftHandButton.isHidden = true
			rightHandButton.isHidden = false
			sliderView.center.x = rightHandButton.center.x
		case .right:
			rightHandButton.isHidden = true
			leftHandButton.isHidden = false
			sliderView.center.x = leftHandButton.center.x
		}
	}
}

// MARK: Make constraints
private extension FingerSizerView {
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
			primaryButton.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 40.scale),
			primaryButton.heightAnchor.constraint(equalToConstant: 54.scale),
			primaryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 71.scale),
			primaryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -71.scale)
		])
		
		NSLayoutConstraint.activate([
			fingerView.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: 47.scale),
			fingerView.bottomAnchor.constraint(equalTo: bottomAnchor),
			fingerView.leadingAnchor.constraint(equalTo: leftHandButton.trailingAnchor, constant: 27.scale)
		])
	
		NSLayoutConstraint.activate([
			sliderView.topAnchor.constraint(equalTo: fingerView.topAnchor, constant: 48.scale),
			sliderView.centerXAnchor.constraint(equalTo: rightHandButton.centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			rightHandButton.widthAnchor.constraint(equalToConstant: 44.scale),
			rightHandButton.heightAnchor.constraint(equalTo: rightHandButton.widthAnchor),
			rightHandButton.leadingAnchor.constraint(equalTo: fingerView.trailingAnchor, constant: 27.scale),
			rightHandButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
			rightHandButton.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 14.scale),
			rightHandButton.bottomAnchor.constraint(equalTo: fingerView.bottomAnchor, constant: -48.scale)
		])
		
		NSLayoutConstraint.activate([
			leftHandButton.widthAnchor.constraint(equalTo: rightHandButton.widthAnchor),
			leftHandButton.heightAnchor.constraint(equalTo: rightHandButton.heightAnchor),
			leftHandButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22.scale),
			leftHandButton.bottomAnchor.constraint(equalTo: rightHandButton.bottomAnchor),
			leftHandButton.topAnchor.constraint(equalTo: rightHandButton.topAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension FingerSizerView {
	func makeHeaderView() -> HeaderView {
		let view = HeaderView(title: "FingerSizer.Title".localized)
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
		view.attributedText = "FingerSizer.Subtitle".localized.attributed(with: attrs)
		view.numberOfLines = 0
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makePrimaryButton() -> PrimaryButton {
		let view = PrimaryButton(title: "FingerSizer.Continue".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeFingerView() -> FingerView {
		let view = FingerView()
		view.layer.borderWidth = 1
		view.layer.borderColor = Appearance.v4Grey.cgColor
		view.backgroundColor = Appearance.v4White
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeSliderView() -> TestVerticalSlider {
		let view = TestVerticalSlider()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.slider.minimumValue = 0
		view.slider.maximumValue = Float(RingSize.allSizes.count - 1)
		view.slider.minimumTrackTintColor = Appearance.v4Grey
		view.slider.maximumTrackTintColor = Appearance.v4Grey
		view.slider.setThumbImage(UIImage(named: "RingSize.Slider"), for: .normal)
		addSubview(view)
		return view
	}
	
	func makeChangeHandButton() -> UIButton {
		let view = UIButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setImage(UIImage(named: "FingerSizer.ChangeHand"), for: .normal)
		addSubview(view)
		return view
	}
	
	func makeBackButton() -> UIButton {
		let view = UIButton()
		view.setImage(UIImage(named: "FingerSizer.Back"), for: .normal)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}

class TestVerticalSlider: UIView {
	
	let slider = RingSlider()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		slider.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
		addSubview(slider)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		slider.bounds.size.width = bounds.height
		slider.center.x = bounds.midX
		slider.center.y = bounds.midY
	}
	
	override var intrinsicContentSize: CGSize {
		get {
			return CGSize(width: slider.intrinsicContentSize.height, height: slider.intrinsicContentSize.width)
		}
	}
}
