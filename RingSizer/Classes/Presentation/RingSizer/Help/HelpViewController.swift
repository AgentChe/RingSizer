//
//  HelpViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 29.03.2024.
//

import UIKit

class HelpViewController: UIViewController {
	
	lazy var mainView = HelpView()
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		mainView.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
}

extension HelpViewController {
	static func make() -> HelpViewController {
		let vc = HelpViewController()
		return vc
	}
}

// MARK: Private
private extension HelpViewController {
	@objc func close() {
		dismiss(animated: true)
	}
}
