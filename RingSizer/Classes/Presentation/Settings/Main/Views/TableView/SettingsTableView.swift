//
//  SettingsTableView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 02.04.2024.
//

import UIKit
import RxCocoa

class SettingsTableView: UITableView {
	
	lazy var elements = [SettingItemsModel]()
	
	let selectedAction = PublishRelay<SettingItemsModel>()

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Public
extension SettingsTableView {
	func setup(elements: [SettingItemsModel]) {
		self.elements = elements
		reloadData()
	}
}

// MARK: UITableViewDataSource
extension SettingsTableView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		elements.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = dequeueReusableCell(withIdentifier: String(describing: SettingsViewCell.self)) as! SettingsViewCell
		let model = elements[indexPath.row]
		cell.setup(title: model.name, isHideLine: indexPath.row == elements.count - 1)
		return cell
	}
}

extension SettingsTableView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let model = elements[indexPath.row]
		selectedAction.accept(model)
	}
}

// MARK: Private
private extension SettingsTableView {
	func initialize() {
		register(SettingsViewCell.self, forCellReuseIdentifier: String(describing: SettingsViewCell.self))
		separatorStyle = .none
		dataSource = self
		delegate = self
	}
}

private extension SettingItemsModel {
	var name: String {
		switch self {
		case .savedSizes:
			return "Settings.SavedSizes".localized
		case .termsOfUse:
			return "Settings.TermsOfUse".localized
		case .privacyPolicy:
			return "Settings.PrivacyPolicy".localized
		case .support:
			return "Settings.Support".localized
		}
	}
}
