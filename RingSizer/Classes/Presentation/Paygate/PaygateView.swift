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
    lazy var imageView = makeImageView()
    lazy var cellLabel1 = makeCellLabel(text: "Paygate.Cell1".localized)
    lazy var cellLabel2 = makeCellLabel(text: "Paygate.Cell2".localized)
    lazy var cellLabel3 = makeCellLabel(text: "Paygate.Cell3".localized)
    lazy var productLeftButton = makeProductButton()
    lazy var productRightButton = makeProductButton()
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
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 358.scale : 325.scale),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 59.scale),
            imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 194.scale : 176.scale)
        ])
        
        NSLayoutConstraint.activate([
            cellLabel1.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellLabel1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 32.scale : 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            cellLabel2.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellLabel2.topAnchor.constraint(equalTo: cellLabel1.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 15.scale : 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            cellLabel3.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellLabel3.topAnchor.constraint(equalTo: cellLabel2.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 15.scale : 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            productLeftButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -8.scale),
            productLeftButton.heightAnchor.constraint(equalToConstant: 146.scale),
            productLeftButton.widthAnchor.constraint(equalToConstant: 171.scale),
            productLeftButton.topAnchor.constraint(equalTo: cellLabel3.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 40.scale : 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            productRightButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 8.scale),
            productRightButton.heightAnchor.constraint(equalToConstant: 146.scale),
            productRightButton.widthAnchor.constraint(equalToConstant: 171.scale),
            productRightButton.topAnchor.constraint(equalTo: cellLabel3.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 40.scale : 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            buyButton.widthAnchor.constraint(equalToConstant: 248.scale),
            buyButton.heightAnchor.constraint(equalToConstant: 54.scale),
            buyButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            buyButton.topAnchor.constraint(equalTo: productLeftButton.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 40.scale : 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            cancelAnytimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            cancelAnytimeLabel.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 34.scale : 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            linksLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            linksLabel.topAnchor.constraint(equalTo: cancelAnytimeLabel.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            restoreButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            restoreButton.topAnchor.constraint(equalTo: linksLabel.bottomAnchor, constant: 12.scale),
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
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "Paygate.Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCellLabel(text: String) -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 16.scale))
            .lineHeight(22.4.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = text.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeProductButton() -> PaygateProductButton {
        let view = PaygateProductButton()
        view.backgroundColor = Appearance.v4White
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBuyButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Paygate.StartTrial".localized.attributed(with: attrs), for: .normal)
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
