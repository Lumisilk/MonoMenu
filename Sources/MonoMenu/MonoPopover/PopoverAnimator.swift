//
//  PopoverAnimator.swift
//  MonoMenu
//
//  Created by lumisilk on 2025/02/21.
//

import UIKit

@MainActor
final class PopoverAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let scale: CGFloat = 0.7
    
    private unowned var sourceView: UIView
    
    var isPresenting: Bool = true
    
    private var presentingAnimator: UIViewPropertyAnimator?
    
    init(sourceView: UIView) {
        self.sourceView = sourceView
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        isPresenting ? 0.3 : 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let duration = transitionDuration(using: transitionContext)
        
        if isPresenting {
            guard let toView = transitionContext.view(forKey: .to),
                  let toViewController = transitionContext.viewController(forKey: .to)
            else { return }
            let finalFrame = transitionContext.finalFrame(for: toViewController)
                        setAnchorPoint(toView, containerView: containerView, finalFrame: finalFrame)
            toView.alpha = 0
            toView.frame = finalFrame
            toView.transform = CGAffineTransform(scaleX: scale, y: scale)
            containerView.addSubview(toView)
            
            let animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8)
            presentingAnimator = animator
            animator.addAnimations { [toView] in
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
            animator.addAnimations { [fromView, scale] in
                fromView.alpha = 0
                fromView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            animator.addCompletion { [fromView] _ in
                fromView.removeFromSuperview()
                transitionContext.finishInteractiveTransition()
                transitionContext.completeTransition(true)
            }
            transitionContext.containerView.isUserInteractionEnabled = false
            animator.startAnimation()
        }
    }
    
    private func setAnchorPoint(_ presentedView: UIView, containerView: UIView, finalFrame: CGRect) {
        let sourceCenter = sourceView.convert(sourceView.bounds.center, to: containerView)
        var x = (sourceCenter.x - finalFrame.minX) / finalFrame.width
        var y = (sourceCenter.y - finalFrame.minY) / finalFrame.height
        x = min(1, max(0, x))
        y = min(1, max(0, y))
        presentedView.layer.anchorPoint = CGPoint(x: x, y: y)
    }
}
