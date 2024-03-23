//
//  SplashViewModel.swift
//  Soccer
//
//  Created by Андрей Чернышев on 05.07.2022.
//

final class SplashViewModel {
    enum Step {
        case onboarding, main, paygate
    }
}

// MARK: Public
extension SplashViewModel {
    func nextStep() -> Step {
        if !OnboardingViewController.wasViewed() {
            return .onboarding
        } else if !SessionManager().hasActiveSubscriptions() {
            return .paygate
        } else {
            return .main
        }
    }
}
