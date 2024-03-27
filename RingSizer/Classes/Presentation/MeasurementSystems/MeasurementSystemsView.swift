//
//  MeasurementSystemsView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 26.03.2024.
//

import UIKit

class MeasurementSystemsView: UIView {

	lazy var titleView = makeTitleView()
	lazy var tableView = makeTableView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = Appearance.v4White
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Make constraints
private extension MeasurementSystemsView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			titleView.topAnchor.constraint(equalTo: topAnchor, constant: 30.scale),
			titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
			
		])
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 11.scale),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -30.scale : -10.scale),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
		])
	}
}

// MARK: Lazy initialization
private extension MeasurementSystemsView {
	func makeTitleView() -> UILabel {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.bold(size: 20.scale))
			.lineHeight(22.scale)
			.textAlignment(.left)
		
		let view = UILabel()
		view.attributedText = "MeasurementSystems.Title".localized.attributed(with: attrs)
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeTableView() -> MeasurementSystemsTableView {
		let view = MeasurementSystemsTableView()
		view.backgroundColor = Appearance.v4White
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
}
