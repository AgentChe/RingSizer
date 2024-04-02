//
//  SavedSizesActionsView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 02.04.2024.
//

import UIKit

class SavedSizesActionsView: UIView {
	
	private lazy var stackView = makeStackView()
	private lazy var grabberView = makeGrabberView()
	private lazy var containerView = makeContainerView()
	
	var selectedAction: ((SavedSizesAction) -> Void)?
	
	init(actions: [SavedSizesAction]) {
		super.init(frame: .zero)
		
		actions
			.enumerated()
			.forEach { index, action in
				let button = makeButtonView(action: action)
				button.isHideSeparator = index == actions.count - 1
				button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
				stackView.addArrangedSubview(button)
			}
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func didTapButton(sender: SavedActionView) {
		selectedAction?(sender.action)
	}
}

// MARK: Make constraints
private extension SavedSizesActionsView {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			grabberView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
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
			stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22.scale),
			stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -26.scale : -5.scale),
			stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension SavedSizesActionsView {
	func makeGrabberView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = Appearance.v4White
		view.layer.cornerRadius = 2.5.scale
		addSubview(view)
		return view
	}
	
	func makeStackView() -> UIStackView {
		let view = UIStackView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.axis = .vertical
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
	
	func makeButtonView(action: SavedSizesAction) -> SavedActionView {
		let view = SavedActionView(action: action)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}
}
