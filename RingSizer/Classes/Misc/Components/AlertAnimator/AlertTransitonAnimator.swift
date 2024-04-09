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
		guard let to = transitionContext.viewController(forKey: .to) else { return }
		let finalFrame = transitionContext.finalFrame(for: to)
		
		to.view.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
		let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
			to.view.frame = finalFrame
		}
		
		animator.addCompletion { (position) in
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		}
		
		animator.startAnimation()
	}
	
	func dismissAnimation(using transitionContext: UIViewControllerContextTransitioning) {
		guard let from = transitionContext.viewController(forKey: .from) else { return }
		let initialFrame = transitionContext.initialFrame(for: from)
				
		let animator = UIViewPropertyAnimator(duration: duration, curve: .easeOut) {
			from.view.frame = initialFrame.offsetBy(dx: 0, dy: initialFrame.height)
		}
				
		animator.addCompletion { (position) in
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		}
		
		animator.startAnimation()
	}
}
