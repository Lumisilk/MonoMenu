//
//  DialogPresenter.swift
//  MonoMenu
//
//  Created by lumisilk on 2025/02/27.
//

import UIKit

final class DialogPresenter: UIPresentationController {
    
    unowned var monoDialog: MonoDialog
    
    private let container = MonoContainerView()
    
    private let dimmingView: UIView = {
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
    
    init(
        monoDialog: MonoDialog,
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController
    ) {
        self.monoDialog = monoDialog
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override var presentedView: UIView? {
        container
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else { return .zero }
        let targetView = presentedViewController.view!
        
        return monoDialog.frameCalculator.calculateFrame(
            containerView: containerView,
            targetView: targetView,
            preferredContentSize: presentedViewController.preferredContentSize
        )
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView else { return }
        
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        
        dismissBackgroundView.frame = containerView.bounds
        containerView.insertSubview(dismissBackgroundView, at: 1)
        
        presentedViewController.transitionCoordinator?.animate { [dimmingView] context in
            dimmingView.alpha = 1
        }
        
        container.setupContentView(presentedViewController.view)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate { [dimmingView] context in
            dimmingView.alpha = 0
        }
    }
    
    @objc private func dismiss() {
        if monoDialog.canDismissByTappingBackground() {
            presentingViewController.dismiss(animated: true)
        }
    }
}
