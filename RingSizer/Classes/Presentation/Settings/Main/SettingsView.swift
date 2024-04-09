//
//  SettingsView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 02.04.2024.
//

import UIKit

class SettingsView: UIView {
	
	lazy var headerView = makeHeaderView()
	lazy var backButton = makeBackButton()
	lazy var tableView = makeTableView()
	
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
private extension SettingsView {
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
			tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension SettingsView {
	func makeHeaderView() -> HeaderView {
		let view = HeaderView(title: "Settings.Title".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.button.isHidden = true
		addSubview(view)
		return view
	}
	
	func makeBackButton() -> TapAreaButton {
		let view = TapAreaButton()
		view.setImage(UIImage(named: "FingerSizer.Back"), for: .normal)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeTableView() -> SettingsTableView {
		let view = SettingsTableView()
		view.backgroundColor = Appearance.v4WarmBeige
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}
