//
//  DialogFrameCalculator.swift
//  MonoMenu
//
//  Created by lumisilk on 2025/02/27.
//

import UIKit

@MainActor
struct DialogFrameCalculator {
    
    var maxWidth: CGFloat = 380
    
    var maxHeight: CGFloat = 570
    
    nonisolated init() {}
    
    private func availableContainerSize(containerView: UIView) -> CGSize {
        CGSize(
            width: min(maxWidth, containerView.bounds.width - 32),
            height: maxHeight
        )
    }
    
    func calculateFrame(containerView: UIView, targetView: UIView, preferredContentSize: CGSize) -> CGRect {
        let proposedSize = preferredContentSize != .zero ? preferredContentSize : availableContainerSize(containerView: containerView)
        let size = targetView.systemLayoutSizeFitting(
            proposedSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .fittingSizeLevel
        )
        let origin = CGPoint(
            x: (containerView.bounds.width - size.width) / 2,
            y: (containerView.bounds.height - size.height) / 2
        )
        return CGRect(origin: origin, size: size)
    }
}
