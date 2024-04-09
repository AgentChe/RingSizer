//
//  SavedSizesViewController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 31.03.2024.
//

import UIKit
import RxSwift
import RxCocoa

class SavedSizesViewController: UIViewController {
	
	lazy var mainView = SavedSizesView()
	private lazy var viewModel = SavedSizesViewModel()
	
	private let selectedAction = PublishRelay<SavedSizesAction>()
	private let didTapDeleteRelay = PublishRelay<Void>()
	private let disposeBag = DisposeBag()
	
	private let alertTransitioningDelegate = AlertTransitioningDelegate()
	private let actionsTransitioningDelegate = SavedActionsTransitionDelegate()
	
	override func loadView() {
		view = mainView
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		let output = viewModel.configure(input: .init(
			selectMoreAction: mainView.tableView.selectMoreAction.asSignal(),
			selectedAction: selectedAction.asSignal(),
			didTapClose: mainView.backButton.rx.tap.asSignal(),
			didTapPrimaryButton: mainView.primaryButton.rx.tap.asSignal(),
			didTapDelete: didTapDeleteRelay.asSignal()
		))
		
		output.elements
			.drive(with: mainView) {
				$0.tableView.setup(elements: $1)
				$0.tableView.isHidden = $1.isEmpty
				$0.emptyContainer.isHidden = !$1.isEmpty
			}
			.disposed(by: disposeBag)
		
		output.route
			.emit(with: self) { $0.route(route: $1) }
			.disposed(by: disposeBag)
		
		mainView.tableView.rx.contentOffset
			.asDriver()
			.debug()
			.drive(with: mainView) { $0.changeHeader(offset: $1.y) }
			.disposed(by: disposeBag)
    }
}

extension SavedSizesViewController {
	static func make() -> SavedSizesViewController {
		let vc = SavedSizesViewController()
		return vc
	}
}

private extension SavedSizesViewController {
	func route(route: SavedSizesViewModel.Route) {
		switch route {
		case .delete:
			showDelete()
		case let .actions(actions):
			showActions(actions: actions)
		case let .share(model):
			showShare(model: model)
		case let .convert(model):
			showConverter(model: model)
		case .measure:
			showMeasureRing()
		case .close:
			navigationController?.popViewController(animated: true)
		}
	}
	
	func showDelete() {
		let vc = DeleteSavedSizeViewController.make { [weak self] in
			self?.didTapDeleteRelay.accept(())
		}
		
		vc.modalPresentationStyle = .custom
		vc.transitioningDelegate = alertTransitioningDelegate
		present(vc, animated: true)
	}
	
	func showActions(actions: [SavedSizesAction]) {
		let vc = SavedSizesActionsViewController.make(actions: actions) { [weak self] action in
			self?.dismiss(animated: true) { [weak self] in
				self?.selectedAction.accept(action)
			}
		}
		
		vc.modalPresentationStyle = .custom
		vc.transitioningDelegate = actionsTransitioningDelegate
		present(vc, animated: true)
	}
	
	func showConverter(model: SavedRingSizeModel) {
		MainCoordinatorMediator.shared.updateTab(tab: .converter(model: model))
		navigationController?.popToRootViewController(animated: true)
	}
	
	func showShare(model: SavedRingSizeModel) {
		let view = ShareView(savedRing: model)
		view.frame = UIScreen.main.bounds
		
		let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
		let image = renderer.image { ctx in
			view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
		}
		
		let ac = UIActivityViewController(activityItems: [image], applicationActivities: nil)
		present(ac, animated: true)
	}
	
	func showMeasureRing() {
		MainCoordinatorMediator.shared.updateTab(tab: .ringSizer)
		navigationController?.popToRootViewController(animated: true)
	}
}
