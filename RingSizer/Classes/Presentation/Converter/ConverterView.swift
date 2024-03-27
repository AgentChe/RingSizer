//
//  ConverterView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 25.03.2024.
//

import UIKit

class ConverterView: UIView {
	
	lazy var headerView = makeHeaderView()
	lazy var subtitle = makeSubtitle()
	lazy var leftDropdown = makeDropdownView()
	lazy var rightDropdown = makeDropdownView()
	lazy var primaryButton = makePrimaryButton()
	lazy var convertedValuelabel = makeConvertedValueLabel()
	lazy var sizeSelector = makeSizeSelector()
	private lazy var converterImage = makeConverterImage()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Make constraints
private extension ConverterView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 26.scale),
			headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			headerView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			subtitle.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 22.scale),
			subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
		])
		
		NSLayoutConstraint.activate([
			sizeSelector.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 60.scale),
			sizeSelector.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44.scale),
			sizeSelector.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44.scale)
		])
		
		NSLayoutConstraint.activate([
			converterImage.topAnchor.constraint(equalTo: sizeSelector.bottomAnchor, constant: 54.scale),
			converterImage.centerXAnchor.constraint(equalTo: centerXAnchor),
			converterImage.leadingAnchor.constraint(equalTo: leftDropdown.trailingAnchor, constant: 17.scale),
			converterImage.trailingAnchor.constraint(equalTo: rightDropdown.leadingAnchor, constant: -17.scale),
			converterImage.heightAnchor.constraint(equalToConstant: 24.scale),
			converterImage.widthAnchor.constraint(equalTo: converterImage.heightAnchor)
		])
		
		NSLayoutConstraint.activate([
			leftDropdown.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44.scale),
			leftDropdown.centerYAnchor.constraint(equalTo: converterImage.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			rightDropdown.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44.scale),
			rightDropdown.centerYAnchor.constraint(equalTo: converterImage.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			convertedValuelabel.topAnchor.constraint(equalTo: converterImage.bottomAnchor, constant: 54.scale),
			convertedValuelabel.heightAnchor.constraint(equalToConstant: 54.scale),
			convertedValuelabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 71.scale),
			convertedValuelabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -71.scale)
		])
		
		NSLayoutConstraint.activate([
			primaryButton.topAnchor.constraint(equalTo: converterImage.bottomAnchor, constant: 54.scale),
			primaryButton.heightAnchor.constraint(equalToConstant: 54.scale),
			primaryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 71.scale),
			primaryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -71.scale)
		])
	}
}

// MARK: Lazy initialization
private extension ConverterView {
	func makeHeaderView() -> HeaderView {
		let view = HeaderView(title: "Converter.Title".localized)
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
		view.attributedText = "Converter.Subtitle".localized.attributed(with: attrs)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeDropdownView() -> DropdownView {
		let view = DropdownView()
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeConverterImage() -> UIImageView {
		let view = UIImageView(image: UIImage(named: "Converter.Convert"))
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makePrimaryButton() -> PrimaryButton {
		let view = PrimaryButton(title: "Converter.Convert".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeConvertedValueLabel() -> UILabel {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeSizeSelector() -> ConverterSizeButton {
		let view = ConverterSizeButton()
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}
