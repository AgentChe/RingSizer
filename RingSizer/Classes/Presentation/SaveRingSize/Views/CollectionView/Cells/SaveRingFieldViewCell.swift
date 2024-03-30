//
//  SaveRingFieldViewCell.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 28.03.2024.
//

import UIKit

class SaveRingFieldViewCell: UICollectionViewCell {
    private lazy var textField = makeTextField()
	private var didEndEditing: ((String) -> Void)?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = Appearance.v4White
		contentView.backgroundColor = Appearance.v4White
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: Public
extension SaveRingFieldViewCell {
	func setup(text: @escaping (String) -> Void) {
		didEndEditing = text
	}
}

// MARK: UITextFieldDelegate
extension SaveRingFieldViewCell: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		didEndEditing?(textField.text ?? "")
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
	}
}

// MARK: Lazy initialization
private extension SaveRingFieldViewCell {
	func makeConstraints() {
		NSLayoutConstraint.activate([
			textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.scale),
			textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.scale),
			textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24.scale),
			textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24.scale)
		])
	}
}

// MARK: Lazy initialization
private extension SaveRingFieldViewCell {
	func makeTextField() -> UITextField {
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey.withAlphaComponent(0.4))
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.4.scale)
			.textAlignment(.left)
		
		let view = UITextField()
		view.delegate = self
		view.textColor = Appearance.v4DarkGrey
		view.translatesAutoresizingMaskIntoConstraints = false
		view.attributedPlaceholder = "SaveSize.Placeholder".localized.attributed(with: attrs)
		contentView.addSubview(view)
		return view
	}
}
