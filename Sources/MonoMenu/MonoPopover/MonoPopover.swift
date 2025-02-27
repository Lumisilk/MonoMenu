//
//  MonoPopover.swift
//  MonoMenu
//
//  Created by lumisilk on 2025/02/27.
//

import UIKit

public final class MonoPopover: NSObject, MonoMenuProtocol {
    
    let sourceView: UIView
    
    lazy var animator = PopoverAnimator(sourceView: sourceView)
    
    let frameCalculator = UIMenuFrameCalculator()
    
    private let interactiveTransition = UIPercentDrivenInteractiveTransition()
    
    public var dimmingBackground: Bool = false
    
    public init(sourceView: UIView) {
        self.sourceView = sourceView
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        animator.isPresenting = true
        return animator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        animator.isPresenting = false
        return animator
    }
    
    public func interactionControllerForPresentation(using animator: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        interactiveTransition
    }
    
    public func interactionControllerForDismissal(using animator: any UIViewControllerAnimatedTransitioning) -> (any UIViewControllerInteractiveTransitioning)? {
        interactiveTransition
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PopoverPresenter(
            monoPopover: self,
            presentedViewController: presented,
            presenting: presenting ?? source
        )
    }
}

public extension MonoMenuProtocol where Self == MonoPopover {
    static func popover(sourceView: UIView) -> MonoPopover {
        MonoPopover(sourceView: sourceView)
    }
}

