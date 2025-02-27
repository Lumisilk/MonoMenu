//
//  MonoMenu+.swift
//  MonoMenu
//
//  Created by lumisilk on 2025/02/20.
//

import UIKit
import ObjectiveC

/// A marker protocol that distinguish the MonoMenu from other UIViewControllerTransitioningDelegate
public protocol MonoMenuProtocol: UIViewControllerTransitioningDelegate {}

public extension UIViewController {
    private struct AssociatedKeys {
        nonisolated(unsafe) static var monoMenuKey = "monoMenuKey"
    }

    public var monoMenu: MonoMenuProtocol? {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.monoMenuKey) as? MonoMenuProtocol
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.monoMenuKey,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            modalPresentationStyle = .custom
            transitioningDelegate = newValue
        }
    }
}
