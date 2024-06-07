//
//  PaygateBestOfferView.swift
//  LocationTracker
//
//  Created by Андрей Чернышев on 20.05.2024.
//

import UIKit

final class PaygateBestOfferView: UIView {
    lazy var label = makeLabel()
    
    private lazy var selectedAttrs = TextAttributes()
        .textColor(Appearance.v4White)
        .font(Fonts.Sen.regular(size: 12.scale))
        .lineHeight(16.8.scale)
        .textAlignment(.center)
    private lazy var deselectedAttrs = TextAttributes()
        .textColor(Appearance.v4DarkGrey)
        .font(Fonts.Sen.regular(size: 12.scale))
        .lineHeight(16.8.scale)
        .textAlignment(.center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PaygateBestOfferView {
    func update(marked: Bool) {
        let attrs = marked ? selectedAttrs : deselectedAttrs
        label.attributedText = "Paygate.BestOffer".localized.attributed(with: attrs)
        
        backgroundColor = marked ? UIColor(integralRed: 52, green: 121, blue: 217) : Appearance.v4White
        
        layer.borderWidth = 2.scale
        layer.borderColor = marked ? UIColor(integralRed: 52, green: 121, blue: 217).cgColor : Appearance.v4Grey.cgColor
    }
}

// MARK: Make constraints
private extension PaygateBestOfferView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.scale),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.scale),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 3.scale),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateBestOfferView {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
