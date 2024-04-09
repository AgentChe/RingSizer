//
//  SavedSizesTableView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 31.03.2024.
//

import UIKit
import RxCocoa

class SavedSizesTableView: UITableView {

	lazy var elements = [SavedRingSizeModel]()
	let selectMoreAction = PublishRelay<SavedRingSizeModel>()
	
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Public
extension SavedSizesTableView {
	func setup(elements: [SavedRingSizeModel]) {
		self.elements = elements
		reloadData()
	}
}

// MARK: UITableViewDataSource
extension SavedSizesTableView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		elements.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = dequeueReusableCell(withIdentifier: String(describing: SavedSizeViewCell.self)) as! SavedSizeViewCell
		let model = elements[indexPath.row]
		cell.setup(model: model) { [weak self] model in
			if let model {
				self?.selectMoreAction.accept(model)
			}
		}
		return cell
	}
}

// MARK: Private
private extension SavedSizesTableView {
	func initialize() {
		register(SavedSizeViewCell.self, forCellReuseIdentifier: String(describing: SavedSizeViewCell.self))
		separatorStyle = .none
		dataSource = self
	}
}
