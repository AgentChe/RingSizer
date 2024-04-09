//
//  ShareView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 09.04.2024.
//

import UIKit

class ShareView: UIView {

	lazy var titleLabel = makeTitle()
	lazy var measureSystemLabel = makeMeasureSystem()
	lazy var sizeLabel = makeRingSize()
	lazy var imageView = makeImageView()
	lazy var cardTitle = makeCardTitle()
	lazy var handLabel = makeRingParamsView()
	lazy var fingerLabel = makeRingParamsView()
	lazy var diameterLabel = makeRingParamsView()
	lazy var elipceView1 = makeElipceView()
	lazy var elipceView2 = makeElipceView()
	
	private lazy var containerView = makeContainer()
	private lazy var paramsContainerView = makeParamsContainer()
	private lazy var ringContainerView = makeRingContainer()
	
	init(savedRing: SavedRingSizeModel) {
		super.init(frame: .zero)
		
		initialize(model: savedRing)
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Private
private extension ShareView {
	func initialize(model: SavedRingSizeModel) {
		backgroundColor = Appearance.v4WarmBeige
		containerView.backgroundColor = .clear
		containerView.layer.borderWidth = 1.scale
		containerView.layer.borderColor = Appearance.v4Grey.cgColor
		containerView.layer.cornerRadius = 30.scale
		
		let titleAttrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.bold(size: 28.scale))
			.lineHeight(33.6.scale)
			.textAlignment(.center)
		
		let measureAttrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.bold(size: 16.scale))
			.lineHeight(26.scale)
			.textAlignment(.right)
		
		let paramAttrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.4.scale)
			.textAlignment(.center)
		
		titleLabel.attributedText = model.name.attributed(with: titleAttrs)
		
		measureSystemLabel.attributedText = model.measureSystem.name.attributed(with: measureAttrs)
		
		sizeLabel.attributedText = sizeAttributes(for: model.sizeValue)
		
		handLabel.attributedText = model.hand.formattedName.attributed(with: paramAttrs)
		fingerLabel.attributedText = model.finger.formattedName.attributed(with: paramAttrs)
		diameterLabel.attributedText = String(format: "Share.DiameterFormat".localized, "\(model.ringSize.diameter)").attributed(with: paramAttrs)
	}
	
	func sizeAttributes(for value: String) -> NSAttributedString {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 76.scale))
			.textAlignment(.center)
		
		let additional = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 40.scale))
			.textAlignment(.center)
			.baselineOffset(30.scale)
		
		return value
			.components(separatedBy: " ")
			.enumerated()
			.reduce(into: NSMutableAttributedString()) { attributes, value in
				let newAttrs = value.offset == 0 ? attrs : additional
				attributes.append(value.element.attributed(with: newAttrs))
			}
	}
}

// MARK: Make constraints
private extension ShareView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30.scale),
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
			containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 194.scale : 176.scale)
		])
		
		NSLayoutConstraint.activate([
			ringContainerView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
			ringContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			ringContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
			ringContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
		])
		
		NSLayoutConstraint.activate([
			cardTitle.topAnchor.constraint(equalTo: ringContainerView.topAnchor, constant: 30.scale),
			cardTitle.leadingAnchor.constraint(equalTo: ringContainerView.leadingAnchor, constant: 30.scale)
		])
		
		NSLayoutConstraint.activate([
			measureSystemLabel.centerYAnchor.constraint(equalTo: cardTitle.centerYAnchor),
			measureSystemLabel.trailingAnchor.constraint(equalTo: ringContainerView.trailingAnchor, constant: -30.scale)
		])
		
		NSLayoutConstraint.activate([
			sizeLabel.centerXAnchor.constraint(equalTo: ringContainerView.centerXAnchor),
			sizeLabel.topAnchor.constraint(equalTo: measureSystemLabel.bottomAnchor, constant: 40.scale)
		])
		
		NSLayoutConstraint.activate([
			paramsContainerView.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 40.scale),
			paramsContainerView.bottomAnchor.constraint(equalTo: ringContainerView.bottomAnchor, constant: -40.scale),
			paramsContainerView.centerXAnchor.constraint(equalTo: ringContainerView.centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			handLabel.leadingAnchor.constraint(equalTo: paramsContainerView.leadingAnchor),
			handLabel.topAnchor.constraint(equalTo: paramsContainerView.topAnchor),
			handLabel.bottomAnchor.constraint(equalTo: paramsContainerView.bottomAnchor)
		])
		
		NSLayoutConstraint.activate([
			elipceView1.heightAnchor.constraint(equalToConstant: 3.scale),
			elipceView1.widthAnchor.constraint(equalTo: elipceView1.heightAnchor),
			elipceView1.centerYAnchor.constraint(equalTo: handLabel.centerYAnchor),
			elipceView1.leadingAnchor.constraint(equalTo: handLabel.trailingAnchor, constant: 9.5.scale)
		])
		
		NSLayoutConstraint.activate([
			fingerLabel.centerYAnchor.constraint(equalTo: handLabel.centerYAnchor),
			fingerLabel.leadingAnchor.constraint(equalTo: elipceView1.trailingAnchor, constant: 9.5.scale)
		])
		
		NSLayoutConstraint.activate([
			elipceView2.heightAnchor.constraint(equalTo: elipceView1.heightAnchor),
			elipceView2.widthAnchor.constraint(equalTo: elipceView2.heightAnchor),
			elipceView2.centerYAnchor.constraint(equalTo: handLabel.centerYAnchor),
			elipceView2.leadingAnchor.constraint(equalTo: fingerLabel.trailingAnchor, constant: 9.5.scale)
		])
		
		NSLayoutConstraint.activate([
			diameterLabel.leadingAnchor.constraint(equalTo: elipceView2.trailingAnchor, constant: 9.5.scale),
			diameterLabel.centerYAnchor.constraint(equalTo: fingerLabel.centerYAnchor),
			diameterLabel.trailingAnchor.constraint(equalTo: paramsContainerView.trailingAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension ShareView {
	func makeContainer() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		view.backgroundColor = Appearance.v4White
		addSubview(view)
		return view
	}
	
	func makeRingContainer() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Appearance.v4White
		containerView.addSubview(view)
		return view
	}
	
	func makeTitle() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeCardTitle() -> UILabel {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.bold(size: 16.scale))
			.lineHeight(26.scale)
			.textAlignment(.left)
		
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.attributedText = "Share.CardTitle".localized.attributed(with: attrs)
		ringContainerView.addSubview(view)
		return view
	}
	
	func makeMeasureSystem() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		ringContainerView.addSubview(view)
		return view
	}
	
	func makeRingSize() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		ringContainerView.addSubview(view)
		return view
	}
	
	func makeParamsContainer() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		ringContainerView.addSubview(view)
		return view
	}
	
	func makeElipceView() -> UIView {
		let view = UIView()
		view.backgroundColor = Appearance.v4DarkGrey
		view.layer.cornerRadius = 1.5.scale
		view.translatesAutoresizingMaskIntoConstraints = false
		ringContainerView.addSubview(view)
		return view
	}
	
	func makeRingParamsView() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		paramsContainerView.addSubview(view)
		return view
	}
	
	func makeImageView() -> UIImageView {
		let view = UIImageView(image: UIImage(named: "Share.Icon"))
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
}
