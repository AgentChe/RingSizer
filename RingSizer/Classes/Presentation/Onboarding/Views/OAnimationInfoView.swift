//
//  OAnimationInfoView.swift
//  RingSizer
//
//  Created by Андрей Чернышев on 23.03.2024.
//

import UIKit
import Lottie

final class OAnimationInfoView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var animationBackground = makeAnimationBackground()
    lazy var animationView = makeAnimationView()
    lazy var continueButton = makeContinueButton()
    lazy var skipButton = makeSkipButton()
    
    private let title: String
    private let animationName: String
    
    override init(step: OnboardingView.Step) {
        switch step {
        case .ringSize:
            title = "Onboarding.RingSize.Title".localized
            animationName = "Onboarding.RingSize.Animation"
        case .converter:
            title = "Onboarding.Convert.Title".localized
            animationName = "Onboarding.Convert.Animation"
        case .saveShare:
            title = "Onboarding.SaveShare.Title".localized
            animationName = "Onboarding.SaveShare.Animation"
        }
        
        super.init(step: step)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        animationView.animation = LottieAnimation.named(animationName)
        animationView.play()
    }
}

// MARK: Private
private extension OAnimationInfoView {
    func initialize() {
        backgroundColor = Appearance.v4WarmBeige
    }
}

// MARK: Make constraints
private extension OAnimationInfoView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 139.scale : 60.scale)
        ])
        
        NSLayoutConstraint.activate([
            animationBackground.widthAnchor.constraint(equalToConstant: 194.scale),
            animationBackground.heightAnchor.constraint(equalToConstant: 194.scale),
            animationBackground.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationBackground.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: 194.scale),
            animationView.heightAnchor.constraint(equalToConstant: 194.scale),
            animationView.centerXAnchor.constraint(equalTo: animationBackground.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: animationBackground.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.widthAnchor.constraint(equalToConstant: 248.scale),
            continueButton.heightAnchor.constraint(equalToConstant: 54.scale),
            continueButton.bottomAnchor.constraint(equalTo: skipButton.topAnchor, constant: -16.scale),
            continueButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            skipButton.widthAnchor.constraint(equalToConstant: 54.scale),
            skipButton.heightAnchor.constraint(equalToConstant: 30.scale),
            skipButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -110.scale : -80.scale),
            skipButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OAnimationInfoView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.bold(size: 28.scale))
            .lineHeight(33.6.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = title.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeAnimationBackground() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Onboarding.Animation")
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeAnimationView() -> LottieAnimationView {
        let view = LottieAnimationView()
        view.contentMode = .scaleAspectFit
        view.loopMode = .playOnce
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeContinueButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Continue".localized.uppercased().attributed(with: attrs), for: .normal)
        view.backgroundColor = Appearance.v4White
        view.layer.borderWidth = 1.scale
        view.layer.borderColor = Appearance.v4DarkGrey.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        addSubview(view)
        return view
    }
    
    func makeSkipButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(Appearance.v4DarkGrey)
            .font(Fonts.Sen.regular(size: 16.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Onboarding.Skip".localized.uppercased().attributed(with: attrs), for: .normal)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(onSkip), for: .touchUpInside)
        addSubview(view)
        return view
    }
}
