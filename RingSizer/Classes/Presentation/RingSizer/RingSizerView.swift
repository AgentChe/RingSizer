//
//  RingSizerView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 27.03.2024.
//

import UIKit
import RxCocoa

class RingSizerView: UIView {
	
	lazy var headerView = makeHeaderView()
	lazy var subtitle = makeSubtitle()
	lazy var containerView = makeContainerView()
	lazy var dropdownView = makeDropdownView()
	lazy var ringView = makeRingView()
	lazy var leftButton = makeButton(imageName: "RingSize.Left")
	lazy var rightButton = makeButton(imageName: "RingSize.Right")
	lazy var sliderView = makeSlider()
	lazy var convertedValuelabel = makeConvertedValueLabel()
	lazy var primaryButton = makePrimaryButton()
	
	let didTapHelp = PublishRelay<Void>()
	
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
private extension RingSizerView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 80.scale : 26.scale),
			headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			subtitle.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 22.scale),
			subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
		])
		
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 47.scale),
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
			containerView.heightAnchor.constraint(equalToConstant: 194.scale)
		])
		
		NSLayoutConstraint.activate([
			ringView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
			ringView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
			ringView.topAnchor.constraint(equalTo: containerView.topAnchor),
			ringView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
			ringView.widthAnchor.constraint(equalTo: ringView.heightAnchor)
		])
		
		NSLayoutConstraint.activate([
			dropdownView.topAnchor.constraint(equalTo: containerView.topAnchor),
			dropdownView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			dropdownView.widthAnchor.constraint(equalToConstant: 110.scale),
		])
		
		NSLayoutConstraint.activate([
			leftButton.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 16.scale),
			leftButton.centerYAnchor.constraint(equalTo: ringView.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			rightButton.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -16.scale),
			rightButton.centerYAnchor.constraint(equalTo: ringView.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			sliderView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 24.scale),
			sliderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			sliderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			convertedValuelabel.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 32.scale),
			convertedValuelabel.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			primaryButton.topAnchor.constraint(equalTo: convertedValuelabel.bottomAnchor, constant: 47.scale),
			primaryButton.heightAnchor.constraint(equalToConstant: 54.scale),
			primaryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 71.scale),
			primaryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -71.scale)
		])
	}
}

// MARK: Lazy initialization
private extension RingSizerView {
	func makeHeaderView() -> HeaderView {
		let view = HeaderView(title: "RingSize.Title".localized)
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
		
		let textAttrs = "\("RingSize.Subtitle".localized) ".attributed(with: attrs)
		let attributedString = NSMutableAttributedString(attributedString: textAttrs)
		
		if let iconImage = UIImage(named: "RingSize.Help") {
			let attachment = NSTextAttachment()
			attachment.image = iconImage
			attachment.bounds = CGRect(x: 0, y: (Fonts.Sen.regular(size: 16.scale).capHeight - iconImage.size.height).rounded() / 2, width: iconImage.size.width, height: iconImage.size.height)
			let imageString = NSAttributedString(attachment: attachment)
			attributedString.append(imageString)
		}
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(helpTapped(sender:)))
		
		let view = UILabel()
		view.addGestureRecognizer(tapGesture)
		view.isUserInteractionEnabled = true
		view.numberOfLines = 0
		view.attributedText = attributedString
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeContainerView() -> UIImageView {
		let view = UIImageView(image: UIImage(named: "RingSize.Background"))
		view.isUserInteractionEnabled = true
		view.layer.borderWidth = 1
		view.layer.borderColor = Appearance.v4Grey.cgColor
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeDropdownView() -> RingSizerDropdown {
		let view = RingSizerDropdown()
		view.layer.borderWidth = 1
		view.layer.borderColor = Appearance.v4Grey.cgColor
		view.backgroundColor = Appearance.v4WarmBeige
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeRingView() -> RingView {
		let view = RingView()
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeButton(imageName: String) -> UIButton {
		let view = UIButton()
		view.setImage(UIImage(named: imageName), for: .normal)
		view.backgroundColor = .clear
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeSlider() -> RingSlider {
		let view = RingSlider()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.minimumValue = 0
		view.maximumValue = Float(RingSize.allSizes.count - 1)
		view.minimumTrackTintColor = Appearance.v4Grey
		view.maximumTrackTintColor = Appearance.v4Grey
		view.setThumbImage(UIImage(named: "RingSize.Slider"), for: .normal)
		addSubview(view)
		return view
	}
	
	func makeConvertedValueLabel() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makePrimaryButton() -> PrimaryButton {
		let view = PrimaryButton(title: "RingSize.Save".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}

// MARK: Private
private extension RingSizerView {
	@objc func helpTapped(sender: UITapGestureRecognizer) {
		didTapHelp.accept(())
	}
}
