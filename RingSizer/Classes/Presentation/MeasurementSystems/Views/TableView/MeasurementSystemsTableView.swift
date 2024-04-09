//
//  MeasurementSystemsTableView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 26.03.2024.
//

import UIKit
import RxCocoa

class MeasurementSystemsTableView: UITableView {

	lazy var didSelectCell = PublishRelay<MeasurementSystem>()
	lazy var elements = [MeasurementSystem]()
	
	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Public
extension MeasurementSystemsTableView {
	func setup(elements: [MeasurementSystem], current: MeasurementSystem) {
		self.elements = elements
		reloadData()
		if let index = elements.firstIndex(where: { $0 == current }) {
			selectRow(at: .init(row: index, section: 0), animated: false, scrollPosition: .middle)
		}
	}
}

// MARK: UITableViewDataSource
extension MeasurementSystemsTableView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		elements.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = dequeueReusableCell(withIdentifier: String(describing: MeasurementSystemViewCell.self)) as! MeasurementSystemViewCell
		cell.setup(type: elements[indexPath.row], isHiddedSeparator: indexPath.row == elements.count - 1)
		return cell
	}
}

// MARK: UITableViewDelegate
extension MeasurementSystemsTableView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let element = elements[indexPath.row]
		didSelectCell.accept(element)
	}
}

// MARK: Private
private extension MeasurementSystemsTableView {
	func initialize() {
		register(MeasurementSystemViewCell.self, forCellReuseIdentifier: String(describing: MeasurementSystemViewCell.self))
		allowsMultipleSelection = false
		separatorStyle = .none
		dataSource = self
		delegate = self
	}
}
