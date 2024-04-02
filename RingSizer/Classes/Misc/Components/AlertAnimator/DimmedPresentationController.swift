//
//  DimmedPresentationController.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 02.04.2024.
//

import UIKit

class DimmedPresentationController: UIPresentationController {
	private lazy var dimmedView: UIView = {
		let view = UIView()
		view.backgroundColor = .black.withAlphaComponent(0.3)
		view.alpha = 0
		return view
	}()
	
	override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
		super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		
		let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe))
		swipeGesture.direction = .down
		presentedView?.addGestureRecognizer(swipeGesture)
	}
	
	override func presentationTransitionWillBegin() {
		super.presentationTransitionWillBegin()
		if let presentedView {
			containerView?.addSubview(presentedView)
		}
		
		containerView?.insertSubview(dimmedView, at: 0)
		animateDimmedView(isPresenting: true)
	}
	
	override func containerViewDidLayoutSubviews() {
		super.containerViewDidLayoutSubviews()
		presentedView?.frame = frameOfPresentedViewInContainerView
		dimmedView.frame = containerView?.frame ?? .zero
	}
	
	override func presentationTransitionDidEnd(_ completed: Bool) {
		super.presentationTransitionDidEnd(completed)
		if !completed {
			dimmedView.removeFromSuperview()
		}
	}
	
	override func dismissalTransitionWillBegin() {
		super.dismissalTransitionWillBegin()
		animateDimmedView(isPresenting: false)
	}
	
	override func dismissalTransitionDidEnd(_ completed: Bool) {
		super.dismissalTransitionDidEnd(completed)
		if completed {
			dimmedView.removeFromSuperview()
		}
	}
	
	private func animateDimmedView(isPresenting: Bool) {
		if let coordinator = presentedViewController.transitionCoordinator {
			coordinator.animate { [weak self] _ in
				self?.dimmedView.alpha = isPresenting ? 1 : 0
			}
		} else {
			dimmedView.alpha = isPresenting ? 1 : 0
		}
	}
	
	@objc func didSwipe(recognizer: UISwipeGestureRecognizer) {
		presentedViewController.dismiss(animated: true)
	}
}
