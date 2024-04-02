//
//  DeleteSavedSizeViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 01.04.2024.
//

import UIKit

class DeleteSavedSizeViewController: UIViewController {
	
	lazy var mainView = DeleteSavedSizeView()
	private var didTapDeleteAction: (() -> Void)?
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		
		mainView.closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
		mainView.secondaryButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
		mainView.primaryButton.addTarget(self, action: #selector(didTapDelete), for: .touchUpInside)
    }
}

extension DeleteSavedSizeViewController {
	static func make(didTapDelete: @escaping () -> Void) -> DeleteSavedSizeViewController {
		let vc = DeleteSavedSizeViewController()
		vc.didTapDeleteAction = didTapDelete
		return vc
	}
}

private extension DeleteSavedSizeViewController {
	@objc func didTapDelete() {
		didTapDeleteAction?()
		dismiss(animated: true)
	}
	
	@objc func didTapClose() {
		dismiss(animated: true)
	}
}
