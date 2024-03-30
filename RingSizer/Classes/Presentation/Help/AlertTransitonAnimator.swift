//
//  AlertTransitonAnimator.swift
//  RingSizer
//
//  Created by Виталий Загороднов on 29.03.2024.
//

import Foundation
import UIKit

class AlertTransitonAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	
	enum AnimationType {
		case present
		case dismiss
	}
	
	let duration: TimeInterval
	let animationType: AnimationType
	
	init(duration: TimeInterval, type: AnimationType) {
		self.duration = duration
		self.animationType = type
	}
	
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		duration
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		switch animationType {
		case .present:
			presentAnimation(using: transitionContext)
		case .dismiss:
			dismissAnimation(using: transitionContext)
		}
	}
}

// MARK: Private
private extension AlertTransitonAnimator {
	func presentAnimation(using transitionContext: UIViewControllerContextTransitioning) {
		guard let toVC = transitionContext.viewController(forKey: .to) else { return }
		toVC.view.frame = transitionContext.finalFrame(for: toVC)
		
		guard let snapshot = toVC.view.snapshotView(afterScreenUpdates: true) else { return }
		let containerView = transitionContext.containerView
		
		
		containerView.addSubview(toVC.view)
		toVC.view.isHidden = true
		
		let backgroundView = UIView()
		backgroundView.frame = toVC.view.frame
		backgroundView.backgroundColor = .black.withAlphaComponent(0.2)
		backgroundView.alpha = 0
		containerView.addSubview(backgroundView)
		
		snapshot.transform = CGAffineTransform(translationX: 0, y: toVC.view.frame.maxY)
		containerView.addSubview(snapshot)
		
		UIView.animate(
			withDuration: duration,
			delay: 0,
			options: [.curveEaseOut],
			animations: {
				snapshot.transform = .identity
				backgroundView.alpha = 1
			},
			completion: { _ in
				toVC.view.backgroundColor = .black.withAlphaComponent(0.2)
				toVC.view.isHidden = false
				snapshot.removeFromSuperview()
				backgroundView.removeFromSuperview()
			
				if transitionContext.transitionWasCancelled {
					toVC.view.removeFromSuperview()
				}
			
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			}
		)
	}
	
	func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
		guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
		
		let containerView = transitionContext.containerView
		
		let backgroundView = UIView()
		backgroundView.frame = fromVC.view.frame
		backgroundView.backgroundColor = .black.withAlphaComponent(0.2)
		containerView.addSubview(backgroundView)
		
		fromVC.view.backgroundColor = .clear
		
		guard let snapshot = fromVC.view.snapshotView(afterScreenUpdates: true) else { return }
		
		fromVC.view.isHidden = true
		
		containerView.addSubview(snapshot)
		
		UIView.animate(
			withDuration: duration,
			delay: 0,
			options: [.curveEaseOut],
			animations: {
				snapshot.transform = CGAffineTransform(translationX: 0, y: fromVC.view.frame.maxY)
				backgroundView.alpha = 0
			},
			completion: { _ in
				snapshot.removeFromSuperview()
				backgroundView.removeFromSuperview()
				
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
			}
		)
	}
}
