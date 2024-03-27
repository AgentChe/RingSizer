//
//  PrimaryButton.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 26.03.2024.
//

import UIKit

class PrimaryButton: UIButton {

	init(title: String) {
		super.init(frame: .zero)
		
		let attrs = TextAttributes()
			.textColor(Appearance.v4DarkGrey)
			.font(Fonts.Sen.regular(size: 16.scale))
			.lineHeight(22.4.scale)
			.textAlignment(.center)
		
		setAttributedTitle(title.attributed(with: attrs), for: .normal)
		
		backgroundColor = Appearance.v4White
		layer.borderWidth = 1.scale
		layer.borderColor = Appearance.v4DarkGrey.cgColor
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
