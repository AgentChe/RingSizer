//
//  PickSizeTableView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 26.03.2024.
//

import UIKit
import RxCocoa

class PickSizeTableView: UITableView {

	lazy var didSelectCell = BehaviorRelay<RingSize?>(value: current)
	lazy var elements = [RingSize]()
	lazy var system: MeasurementSystem = .au
	var current: RingSize? = nil

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		
		initialize()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Public
extension PickSizeTableView {
	func setup(elements: [RingSize], system: MeasurementSystem, current: RingSize?) {
		self.elements = elements
		self.system = system
		self.current = current
		
		reloadData()
		if let index = elements.firstIndex(where: { $0 == current }) {
			selectRow(at: .init(row: index, section: 0), animated: false, scrollPosition: .middle)
		}
	}
}

// MARK: UITableViewDataSource
extension PickSizeTableView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		elements.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = dequeueReusableCell(withIdentifier: String(describing: PickSizeViewCell.self)) as! PickSizeViewCell
		let size = elements[indexPath.row]
		cell.setup(size: size, type: system, isHiddedSeparator: indexPath.row == elements.count - 1)
		return cell
	}
}

// MARK: UITableViewDelegate
extension PickSizeTableView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let element = elements[indexPath.row]
		didSelectCell.accept(element)
	}
}

// MARK: Private
private extension PickSizeTableView {
	func initialize() {
		register(PickSizeViewCell.self, forCellReuseIdentifier: String(describing: PickSizeViewCell.self))
		allowsMultipleSelection = false
		separatorStyle = .none
		dataSource = self
		delegate = self
	}
}
