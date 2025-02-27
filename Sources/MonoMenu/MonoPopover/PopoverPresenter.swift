//
//  PopoverPresenter.swift
//  MonoMenu
//
//  Created by lumisilk on 2025/02/27.
//

import UIKit

final class PopoverPresenter: UIPresentationController {
    
    unowned var monoPopover: MonoPopover
    
    private let container = MonoContainerView()
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    
    private lazy var dismissBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        return view
    }()
    
    private lazy var gestureFallbackView: GestureFallbackView = GestureFallbackView(
        backgroundView: presentingViewController.rootViewController.view!,
        action: { [presentingViewController] in
            presentingViewController.dismiss(animated: true)
        }
    )
    
    init(
        monoPopover: MonoPopover,
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController
    ) {
        self.monoPopover = monoPopover
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override var presentedView: UIView? {
        container
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else { return .zero }
        let targetView = presentedViewController.view!
        
        return monoPopover.frameCalculator.calculateFrame(
            containerView: containerView,
            sourceView: monoPopover.sourceView,
            targetView: targetView,
            preferredContentSize: presentedViewController.preferredContentSize
        )
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView else { return }
        
        if monoPopover.dimmingBackground {
            dimmingView.frame = containerView.bounds
            dimmingView.alpha = 0
            containerView.insertSubview(dimmingView, at: 0)
            
            presentedViewController.transitionCoordinator?.animate { [dimmingView] context in
                dimmingView.alpha = 1
            }
            
            dismissBackgroundView.frame = containerView.bounds
            containerView.insertSubview(dismissBackgroundView, at: 1)
            
        } else {
            gestureFallbackView.frame = containerView.bounds
            containerView.addSubview(gestureFallbackView)
        }
        
        container.setupContentView(presentedViewController.view)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate { [dimmingView] context in
            dimmingView.alpha = 0
        }
    }
    
    @objc private func dismiss() {
        if monoPopover.canDismissByTappingBackground() {
            presentingViewController.dismiss(animated: true)
        }
    }
}
