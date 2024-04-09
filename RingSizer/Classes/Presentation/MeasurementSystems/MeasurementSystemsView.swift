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
	private lazy var containerView = makeContainerView()
	private lazy var grabberView = makeGrabberView()
	

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .clear
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
			grabberView.topAnchor.constraint(equalTo: topAnchor),
			grabberView.heightAnchor.constraint(equalToConstant: 5.scale),
			grabberView.widthAnchor.constraint(equalToConstant: 36.scale),
			grabberView.centerXAnchor.constraint(equalTo: centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			containerView.topAnchor.constraint(equalTo: grabberView.bottomAnchor, constant: 4.scale),
			containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
			containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
		
		NSLayoutConstraint.activate([
			titleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30.scale),
			titleView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16.scale),
			titleView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16.scale)
			
		])
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 11.scale),
			tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -30.scale : -10.scale),
			tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16.scale),
			tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16.scale)
		])
	}
}

// MARK: Lazy initialization
private extension MeasurementSystemsView {
	func makeGrabberView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Appearance.v4White
		view.layer.cornerRadius = 2.5.scale
		addSubview(view)
		return view
	}
	
	func makeTitleView() -> UILabel {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.bold(size: 20.scale))
			.lineHeight(22.scale)
			.textAlignment(.left)
		
		let view = UILabel()
		view.attributedText = "MeasurementSystems.Title".localized.attributed(with: attrs)
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeTableView() -> MeasurementSystemsTableView {
		let view = MeasurementSystemsTableView()
		view.backgroundColor = Appearance.v4White
		view.isScrollEnabled = false
		view.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(view)
		return view
	}
	
	func makeContainerView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Appearance.v4White
		addSubview(view)
		return view
	}
}
