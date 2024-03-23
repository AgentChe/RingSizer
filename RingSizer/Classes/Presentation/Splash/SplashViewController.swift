//
//  SplashViewController.swift
//  Soccer
//
//  Created by Андрей Чернышев on 05.07.2022.
//

import UIKit
import RxSwift
import Lottie

final class SplashViewController: UIViewController {
    lazy var mainView = SplashView()
    
    private lazy var viewModel = SplashViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var sdkInitialize = SplashReceiptValidationObserver()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sdkInitialize.observe { [weak self] in
            guard let self else {
                return
            }
            
            let step = self.viewModel.nextStep()
            self.goNext(at: step)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimation()
    }
}

// MARK: Make
extension SplashViewController {
    static func make() -> SplashViewController {
        SplashViewController()
    }
}

// MARK: Private
private extension SplashViewController {
    func startAnimation() {
        mainView.animationView.animation = LottieAnimation.named("Splash.Animation")
        mainView.animationView.play()
    }
    
    func goNext(at step: SplashViewModel.Step) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            self?.openScreen(at: step)
        }
    }
    
    func openScreen(at step: SplashViewModel.Step) {
        switch step {
        case .onboarding:
            UIApplication.shared.keyWindow?.rootViewController = OnboardingViewController.make()
        case .main:
            UIApplication.shared.keyWindow?.rootViewController = MainViewController.make()
        case .paygate:
            let vc = PaygateViewController.make { [weak self] in
                self?.goNext(at: .main)
            }
            present(vc, animated: true)
        }
    }
}
