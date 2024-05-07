//
//  PaygateView.swift
//  CodeChallenge
//
//  Created by Андрей Чернышев on 20.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

final class PaygateView: UIView {
    lazy var closeButton = makeCloseButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var imageView = makeImageView()
    lazy var cell1 = makeCell(key: "Paygate.Cell1")
    lazy var cell2 = makeCell(key: "Paygate.Cell2")
    lazy var cell3 = makeCell(key: "Paygate.Cell3")
    lazy var separator = makeSeparator()
    lazy var priceLabel = makeLabel()
    lazy var buyButton = makeBuyButton()
    lazy var cancelAnytimeLabel = makeCancelAnytimeLabel()
    lazy var linksLabel = makeLinksLabel()
    lazy var restoreButton = makeRestoreButton()
    lazy var preloader = makePreloader()
    
    private lazy var didTapTermsOfUseTrigger = PublishRelay<Void>()
    private lazy var didTapPrivacyPolicyTrigger = PublishRelay<Void>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PaygateView {
    func setup(product: ProductPrice) {
        guard let price = Currency(productPrice: product).formatted() else {
            return
        }
        
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.bold(size: 16.scale))
            .textAlignment(.center)
        let priceAttrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.bold(size: 28.scale))
            .textAlignment(.center)
        
        let result = NSMutableAttributedString()
        result.append("Paygate.Price".localized.attributed(with: attrs))
        result.append(price.attributed(with: priceAttrs))
        
        priceLabel.attributedText = result
    }
    
    var didTapTermsOfUse: Signal<Void> {
        didTapTermsOfUseTrigger.asSignal()
    }
    
    var didTapPrivacyPolicy: Signal<Void> {
        didTapPrivacyPolicyTrigger.asSignal()
    }
}

// MARK: Private
private extension PaygateView {
    func initialize() {
        backgroundColor = Appearance.v4WarmBeige
    }
    
    @objc
    func termsAndPolicyTapped(sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel, let text = label.text as NSString? else {
            return
        }
        
        let termsRange = text.range(of: "Paygate.TermsOfUse".localized)
        let policyRange = text.range(of: "Paygate.PrivacyPolicy".localized)

        if sender.didTapAttributedTextInLabel(label: label, inRange: termsRange) {
            didTapTermsOfUseTrigger.accept(Void())
        } else if sender.didTapAttributedTextInLabel(label: label, inRange: policyRange) {
            didTapPrivacyPolicyTrigger.accept(Void())
        }
    }
}

// MARK: Make constraints
private extension PaygateView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 24.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 24.scale),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 358.scale : 345.scale),
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 18.scale : 10.scale),
            imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 194.scale : 186.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell1.leadingAnchor.constraint(equalTo: leadingAnchor),
            cell1.trailingAnchor.constraint(equalTo: trailingAnchor),
            cell1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 36.scale : 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell2.leadingAnchor.constraint(equalTo: leadingAnchor),
            cell2.trailingAnchor.constraint(equalTo: trailingAnchor),
            cell2.topAnchor.constraint(equalTo: cell1.bottomAnchor, constant: 6.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell3.leadingAnchor.constraint(equalTo: leadingAnchor),
            cell3.trailingAnchor.constraint(equalTo: trailingAnchor),
            cell3.topAnchor.constraint(equalTo: cell2.bottomAnchor, constant: 6.scale)
        ])
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            separator.heightAnchor.constraint(equalToConstant: 1.scale),
            separator.topAnchor.constraint(equalTo: cell3.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 36.scale : 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            priceLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 36.scale : 20.scale)
        ])
        
        NSLayoutConstraint.activate([
            buyButton.widthAnchor.constraint(equalToConstant: 248.scale),
            buyButton.heightAnchor.constraint(equalToConstant: 54.scale),
            buyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            buyButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            cancelAnytimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cancelAnytimeLabel.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 16.scale : 10.scale)
        ])
        
        NSLayoutConstraint.activate([
            linksLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            linksLabel.topAnchor.constraint(equalTo: cancelAnytimeLabel.bottomAnchor, constant: 59.scale)
        ])
        
        NSLayoutConstraint.activate([
            restoreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            restoreButton.topAnchor.constraint(equalTo: linksLabel.bottomAnchor, constant: 8.scale),
            restoreButton.heightAnchor.constraint(equalToConstant: 14.4.scale)
        ])
        
        NSLayoutConstraint.activate([
            preloader.widthAnchor.constraint(equalToConstant: 45.scale),
            preloader.heightAnchor.constraint(equalToConstant: 45.scale),
            preloader.centerXAnchor.constraint(equalTo: buyButton.centerXAnchor),
            preloader.centerYAnchor.constraint(equalTo: buyButton.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateView {
    func makeCloseButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Paygate.Close"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 16, green: 26, blue: 39))
            .font(Fonts.Sen.bold(size: 20.scale))
            .lineHeight(22.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Paygate.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: ScreenSize.isIphoneXFamily ? "Paygate.Image.X" : "Paygate.Image.8")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCell(key: String) -> PaygateCell {
        let view = PaygateCell(key: key)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = Appearance.v4Grey
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBuyButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Paygate.BuyButton".localized.uppercased().attributed(with: attrs), for: .normal)
        view.layer.borderWidth = 1.scale
        view.layer.borderColor = Appearance.v4DarkGrey.cgColor
        view.backgroundColor = Appearance.v4White
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCancelAnytimeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 12.scale))
            .lineHeight(14.4.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Paygate.CancelAnytime".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLinksLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 12.scale))
            .lineHeight(14.4.scale)
            .textAlignment(.center)
        
        let string = [
            "Paygate.TermsOfUse".localized,
            "Paygate.&".localized,
            "Paygate.PrivacyPolicy".localized
            ]
            .joined(separator: " ")
            .reduce(NSMutableAttributedString()) { result, string -> NSMutableAttributedString in
                result.append(String(string).attributed(with: attrs))
                return result
            }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndPolicyTapped(sender:)))
        
        let view = UILabel()
        view.attributedText = string
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeRestoreButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 12.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Paygate.Restore".localized.attributed(with: attrs), for: .normal)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePreloader() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.color = Appearance.v4DarkGrey
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
