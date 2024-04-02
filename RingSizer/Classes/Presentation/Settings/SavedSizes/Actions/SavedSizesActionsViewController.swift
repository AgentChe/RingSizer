//
//  SavedSizesActionsViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 03.04.2024.
//

import UIKit

class SavedSizesActionsViewController: UIViewController {
	
	let mainView: SavedSizesActionsView
	
	override func loadView() {
		view = mainView
	}
	
	init(actions: [SavedSizesAction]) {
		self.mainView = SavedSizesActionsView(actions: actions)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SavedSizesActionsViewController {
	static func make(actions: [SavedSizesAction], didSelectAction: @escaping (SavedSizesAction) -> Void) -> SavedSizesActionsViewController {
		let vc = SavedSizesActionsViewController(actions: actions)
		vc.mainView.selectedAction = didSelectAction
		return vc
	}
}
