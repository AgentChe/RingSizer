//
//  PickSizeView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 26.03.2024.
//

import UIKit

final class PickSizeView: UIView {
	
	lazy var tableView = makeTableView()
	lazy var primaryButton = makePrimaryButton()
	lazy var closeButton = makeCloseButton()
	lazy var titleView = makeTitle()

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
private extension PickSizeView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			titleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.scale),
			titleView.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			closeButton.widthAnchor.constraint(equalToConstant: 24.scale),
			closeButton.heightAnchor.constraint(equalToConstant: 24.scale),
			closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
			closeButton.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
		])
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16.scale),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
		])
		
		NSLayoutConstraint.activate([
			primaryButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20.scale),
			primaryButton.heightAnchor.constraint(equalToConstant: 54.scale),
			primaryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 71.scale),
			primaryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -71.scale),
			primaryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -50.scale : -35.scale)
		])
	}
}

// MARK: Lazy initialization
private extension PickSizeView {
	func makeTableView() -> PickSizeTableView {
		let view = PickSizeTableView()
		view.backgroundColor = Appearance.v4WarmBeige
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makePrimaryButton() -> PrimaryButton {
		let view = PrimaryButton(title: "PickSize.Select".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeTitle() -> UILabel {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.bold(size: 20.scale))
			.lineHeight(22.scale)
			.textAlignment(.center)
		
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.attributedText = "PickSize.Title".localized.attributed(with: attrs)
		addSubview(view)
		return view
	}
	
	func makeCloseButton() -> TapAreaButton {
		let view = TapAreaButton()
		view.setImage(UIImage(named: "Paygate.Close"), for: .normal)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}
