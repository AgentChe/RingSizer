//
//  SavedSizeViewCell.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 31.03.2024.
//

import UIKit

class SavedSizeViewCell: UITableViewCell {
	lazy var nameLabel = makeNameLabel()
	lazy var moreButton = makeMoreButton()
	lazy var sizeLabel = makeSizeLabel()
	lazy var handLabel = makeHandLabel()
	lazy var fingerLabel = makeFingerLabel()
	private lazy var ringContainerView = makeRingContainerView()
	private lazy var containerView = makeContainerView()
	private lazy var elipceView = makeElipceView()
	
	private var didTapMore: ((SavedRingSizeModel?) -> Void)?
	private var model: SavedRingSizeModel?
	
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
extension SavedSizeViewCell {
	func setup(model: SavedRingSizeModel, didTapMore: @escaping (SavedRingSizeModel?) -> Void) {
		self.didTapMore = didTapMore
		self.model = model
		
		nameLabel.attributedText = model.name.attributed(with: SavedSizeViewCell.nameAttrs)
		sizeLabel.attributedText = model.ringSize.size(by: model.measureSystem).attributed(with: SavedSizeViewCell.sizeAttrs)
		handLabel.attributedText = model.hand.formattedName.attributed(with: SavedSizeViewCell.handAttrs)
		fingerLabel.attributedText = model.finger.formattedName.attributed(with: SavedSizeViewCell.fingerAttrs)
	}
}

// MARK: Private
private extension SavedSizeViewCell {
	func initialize() {
		backgroundColor = .clear
		contentView.backgroundColor = .clear
		selectionStyle = .none
	}
}

// MARK: Make constraints
private extension SavedSizeViewCell {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.scale),
			containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.scale),
			containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
			containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
		])
		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24.scale),
			nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 28.scale)
		])
		
		NSLayoutConstraint.activate([
			moreButton.heightAnchor.constraint(equalToConstant: 24.scale),
			moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor),
			moreButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24.scale),
			moreButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24.scale),
			moreButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 24.scale)
		])
		
		NSLayoutConstraint.activate([
			ringContainerView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 34.scale),
			ringContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -58.scale),
			ringContainerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			sizeLabel.topAnchor.constraint(equalTo: ringContainerView.topAnchor),
			sizeLabel.leadingAnchor.constraint(equalTo: ringContainerView.leadingAnchor),
			sizeLabel.trailingAnchor.constraint(equalTo: ringContainerView.trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			elipceView.centerXAnchor.constraint(equalTo: ringContainerView.centerXAnchor),
			elipceView.heightAnchor.constraint(equalToConstant: 3.scale),
			elipceView.widthAnchor.constraint(equalTo: elipceView.heightAnchor),
			elipceView.centerYAnchor.constraint(equalTo: handLabel.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			handLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 34.scale),
			handLabel.bottomAnchor.constraint(equalTo: ringContainerView.bottomAnchor),
			handLabel.leadingAnchor.constraint(equalTo: ringContainerView.leadingAnchor),
			handLabel.trailingAnchor.constraint(equalTo: elipceView.leadingAnchor, constant: -18.scale)
		])
		
		NSLayoutConstraint.activate([
			fingerLabel.topAnchor.constraint(equalTo: handLabel.topAnchor),
			fingerLabel.bottomAnchor.constraint(equalTo: fingerLabel.bottomAnchor),
			fingerLabel.trailingAnchor.constraint(equalTo: ringContainerView.trailingAnchor),
			fingerLabel.leadingAnchor.constraint(equalTo: elipceView.trailingAnchor, constant: 18.scale)
		])
	}
}

// MARK: Lazy initialization
private extension SavedSizeViewCell {
	func makeNameLabel() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeMoreButton() -> UIButton {
		let view = UIButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.setImage(UIImage(named: "SavedSizes.More"), for: .normal)
		view.addTarget(self, action: #selector(tapMore), for: .touchUpInside)
		containerView.addSubview(view)
		return view
	}
	
	func makeSizeLabel() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		ringContainerView.addSubview(view)
		return view
	}
	
	func makeHandLabel() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		ringContainerView.addSubview(view)
		return view
	}
	
	func makeFingerLabel() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		ringContainerView.addSubview(view)
		return view
	}
	
	func makeRingContainerView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .clear
		containerView.addSubview(view)
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
	
	func makeContainerView() -> UIView {
		let view = UIView()
		view.backgroundColor = Appearance.v4White
		view.layer.borderWidth = 1
		view.layer.borderColor = Appearance.v4Grey.cgColor
		view.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(view)
		return view
	}
}

private extension SavedSizeViewCell {
	@objc func tapMore() {
		didTapMore?(model)
	}
}

private extension SavedSizeViewCell {
	static let nameAttrs = TextAttributes()
		.textColor(Appearance.v4DarkGrey)
		.font(Fonts.Sen.bold(size: 16.scale))
		.lineHeight(26.scale)
		.textAlignment(.left)
	
	static let sizeAttrs = TextAttributes()
		.textColor(Appearance.v4DarkGrey)
		.font(Fonts.Sen.regular(size: 58.scale))
		.textAlignment(.center)
	
	static let handAttrs = TextAttributes()
		.textColor(Appearance.v4DarkGrey)
		.font(Fonts.Sen.regular(size: 16.scale))
		.lineHeight(22.4.scale)
		.textAlignment(.right)
	
	static let fingerAttrs = TextAttributes()
		.textColor(Appearance.v4DarkGrey)
		.font(Fonts.Sen.regular(size: 16.scale))
		.lineHeight(22.4.scale)
		.textAlignment(.left)
}

private extension Hand {
	var formattedName: String {
		switch self {
		case .left:
			return "SavedSizes.LeftHand".localized
		case .right:
			return "SavedSizes.RightHand".localized
		}
	}
}

private extension Finger {
	var formattedName: String {
		switch self {
		case .thumb:
			return "SavedSizes.ThumbFinger".localized
		case .index:
			return "SavedSizes.IndexFinger".localized
		case .middle:
			return "SavedSizes.MiddleFinger".localized
		case .ring:
			return "SavedSizes.RingFinger".localized
		case .pinky:
			return "SavedSizes.PinkyFinger".localized
		}
	}
}
