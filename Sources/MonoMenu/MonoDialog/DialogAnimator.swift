//
//  MonoAnimator.swift
//  MonoMenu
//
//  Created by lumisilk on 2024/12/08.
//

import UIKit

final class DialogAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private let scale: CGFloat = 0.9
    
    var isPresenting: Bool = true
    
    private var presentingAnimator: UIViewPropertyAnimator?
    
    func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        isPresenting ? 0.3 : 0.2
    }
    
    func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
        if isPresenting {
            guard let toView = transitionContext.view(forKey: .to),
                  let toViewController = transitionContext.viewController(forKey: .to)
            else { return }
            let finalFrame = transitionContext.finalFrame(for: toViewController)
            
            toView.alpha = 0
            toView.frame = finalFrame
            toView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            containerView.addSubview(toView)
            
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1)
            presentingAnimator = animator
            animator.addAnimations {
                toView.alpha = 1
                toView.transform = .identity
            }
            animator.addCompletion { [weak self] _ in
                self?.presentingAnimator = nil
            }
            animator.startAnimation()
            transitionContext.finishInteractiveTransition()
            transitionContext.completeTransition(true)
            
        } else {
            guard let fromView = transitionContext.view(forKey: .from) else { return }
            presentingAnimator?.stopAnimation(true)
            
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1)
            animator.addAnimations { [scale] in
                fromView.alpha = 0
                fromView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            animator.addCompletion { [weak self] position in
                fromView.removeFromSuperview()
                transitionContext.finishInteractiveTransition()
                transitionContext.completeTransition(true)
            }
            transitionContext.containerView.isUserInteractionEnabled = false
            animator.startAnimation()
        }
    }
}
