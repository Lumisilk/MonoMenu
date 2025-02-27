//
//  MonoDialog.swift
//  MonoMenu
//
//  Created by lumisilk on 2025/02/27.
//

import UIKit

public final class MonoDialog: NSObject, MonoMenuProtocol {
    
    let animator = DialogAnimator()
    
    let frameCalculator = DialogFrameCalculator()
    
    private let interactiveTransition = UIPercentDrivenInteractiveTransition()
    
    public var canDismissByTappingBackground: () -> Bool = { true }
    
    public override init() {}
    
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
        DialogPresenter(
            monoDialog: self,
            presentedViewController: presented,
            presenting: presenting ?? source
        )
    }
}

public extension MonoMenuProtocol where Self == MonoDialog {
    static var dialog: MonoDialog {
        MonoDialog()
    }
}
