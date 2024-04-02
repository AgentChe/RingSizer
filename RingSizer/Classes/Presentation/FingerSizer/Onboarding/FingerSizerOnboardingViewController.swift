//
//  FingerSizerOnboardingViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 30.03.2024.
//

import UIKit

class FingerSizerOnboardingViewController: UIViewController {
	
	lazy var mainView = FingerSizerOnboardingView()
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		mainView.primaryButton.addTarget(self, action: #selector(showSizer), for: .touchUpInside)
		mainView.headerView.button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
    }
}

extension FingerSizerOnboardingViewController {
	@objc func showSizer() {
		let vc = FingerSizerViewController.make()
		navigationController?.pushViewController(vc, animated: true)
	}
	
	@objc func openSettings() {
		let vc = SettingsViewController.make()
		navigationController?.pushViewController(vc, animated: true)
	}
}
