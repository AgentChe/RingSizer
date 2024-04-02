//
//  SavedSizesView.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 31.03.2024.
//

import UIKit

class SavedSizesView: UIView {
	
	lazy var headerView = makeHeaderView()
	lazy var subtitle = makeSubtitle()
	lazy var imageView = makeImageView()
	lazy var primaryButton = makePrimaryButton()
	lazy var backButton = makeBackButton()
	lazy var tableView = makeTableView()
	private lazy var dimmedView = makeDimmedView()

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
private extension SavedSizesView {
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
			subtitle.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 22.scale),
			subtitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
			subtitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
		])
		
		NSLayoutConstraint.activate([
			imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			imageView.widthAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 358.scale : 325.scale),
			imageView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 93.scale),
			imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 194.scale : 176.scale)
		])
		
		NSLayoutConstraint.activate([
			primaryButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30.scale),
			primaryButton.heightAnchor.constraint(equalToConstant: 54.scale),
			primaryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 71.scale),
			primaryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -71.scale)
		])
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
			tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
		
		NSLayoutConstraint.activate([
			dimmedView.topAnchor.constraint(equalTo: topAnchor),
			dimmedView.leadingAnchor.constraint(equalTo: leadingAnchor),
			dimmedView.trailingAnchor.constraint(equalTo: trailingAnchor),
			dimmedView.bottomAnchor.constraint(equalTo: bottomAnchor)
		])
	}
}

// MARK: Lazy initialization
private extension SavedSizesView {
	func makeHeaderView() -> HeaderView {
		let view = HeaderView(title: "SavedSizes.Title".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.button.isHidden = true
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
		view.attributedText = "SavedSizes.Subtitle".localized.attributed(with: attrs)
		view.numberOfLines = 0
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeImageView() -> UIImageView {
		let view = UIImageView()
		view.contentMode = .scaleAspectFit
		view.clipsToBounds = true
		view.image = UIImage(named: "SavedSizes.Image")
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makePrimaryButton() -> PrimaryButton {
		let view = PrimaryButton(title: "SavedSizes.MeasureRing".localized)
		view.translatesAutoresizingMaskIntoConstraints = false
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
	
	func makeTableView() -> SavedSizesTableView {
		let view = SavedSizesTableView()
		view.backgroundColor = Appearance.v4WarmBeige
		view.translatesAutoresizingMaskIntoConstraints = false
		addSubview(view)
		return view
	}
	
	func makeActionsView(actions: [SavedSizesAction]) -> SavedSizesActionsView {
		let view = SavedSizesActionsView(actions: actions)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}
	
	func makeDimmedView() -> UIView {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
		view.alpha = 0
		addSubview(view)
		return view
	}
}
