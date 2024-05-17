//
//  PaygateProductButton.swift
//  RingSizer
//
//  Created by Андрей Чернышев on 25.03.2024.
//

import UIKit

final class PaygateProductButton: UIButton {
    lazy var marked = false {
        didSet {
            update()
        }
    }
    
    private(set) var product: ProductPrice?
    
    lazy var nameLabel = makeLabel()
    lazy var contentLabel = makeLabel()
    lazy var discountLabel = makeDiscountLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PaygateProductButton {
    func setup(product: ProductPrice, discountBy: ProductPrice? = nil) {
        self.product = product
        
        fill(product: product, discountBy: discountBy)
    }
}

// MARK: Private
private extension PaygateProductButton {
    func update() {
        layer.borderWidth = 1.scale
        layer.borderColor = marked ? Appearance.v4DarkGrey.cgColor : UIColor(integralRed: 224, green: 224, blue: 224).cgColor
    }
    
    func fill(product: ProductPrice, discountBy: ProductPrice?) {
        fillName(product: product)
        fillContent(product: product)
        fillDiscount(product: product, discountBy: discountBy)
    }
    
    func fillName(product: ProductPrice) {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.bold(size: 16.scale))
            .lineHeight(26.scale)
            .textAlignment(.left)
        
        let isMonthly = product.id == GlobalDefinitions.Paygate.monthly
        let name = isMonthly ? "Paygate.MonthlyPlan".localized : "Paygate.AnnualPlan".localized
        
        nameLabel.attributedText = name.attributed(with: attrs)
    }
    
    func fillContent(product: ProductPrice) {
        guard let price = Currency(productPrice: product).formatted() else {
            return
        }
        
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 14.scale))
            .lineHeight(19.6.scale)
            .textAlignment(.left)
        
        let isMonthly = product.id == GlobalDefinitions.Paygate.monthly
        let key = isMonthly ? "Paygate.PriceMonthly" : "Paygate.PriceYearly"
        let string = String(format: key.localized, price)
        
        contentLabel.attributedText = string.attributed(with: attrs)
    }
    
    func fillDiscount(product: ProductPrice, discountBy: ProductPrice?) {
        discountLabel.isHidden = discountBy == nil
        
        guard let discountBy else {
            return
        }
        
        let priceDiv: Double = product.priceValue / 12
        let diff = discountBy.priceValue - priceDiv
        let discount = Int(100 / (discountBy.priceValue / diff))
        
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.bold(size: 14.scale))
            .lineHeight(16.4.scale)
        
        let string = String(format: "Paygate.Save".localized, discount)
        
        discountLabel.attributedText = string.attributed(with: attrs)
    }
}

// MARK: Make constraints
private extension PaygateProductButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            contentLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            contentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            discountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            discountLabel.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateProductButton {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDiscountLabel() -> PaddingLabel {
        let view = PaddingLabel()
        view.insets = UIEdgeInsets(vertical: 2.scale, horizontal: 3.scale)
        view.layer.cornerRadius = 6.scale
        view.layer.masksToBounds = true
        view.backgroundColor = Appearance.v4Yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
