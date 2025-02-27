//
//  UIKit+.swift
//  MonoMenu
//
//  Created by lumisilk on 2024/12/08.
//


import UIKit

extension CGSize {
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width  + rhs.width, height: lhs.height + rhs.height)
    }
}

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    
    func chebyshevDistance(to point: CGPoint) -> CGFloat {
        let xDistance: CGFloat =
        switch point.x {
        case ..<minX:
            minX - point.x
        case maxX...:
            point.x - maxX
        default:
            0
        }
        
        let yDistance: CGFloat =
        switch point.y {
        case ..<minY:
            minY - point.y
        case maxY...:
            point.y - maxY
        default:
            0
        }
        
        return max(xDistance, yDistance)
    }
}

extension UIView {
    var globalFrame: CGRect {
        convert(bounds, to: nil)
    }
    
    var safeAreaWidth: CGFloat {
        bounds.width - safeAreaInsets.left - safeAreaInsets.right
    }
    
    var safeAreaHeight: CGFloat {
        bounds.height - safeAreaInsets.top - safeAreaInsets.bottom
    }
}

extension UIViewController {
    var rootViewController: UIViewController {
        var current = self
        while let next = current.parent {
            current = next
        }
        return current
    }
}

extension UIDevice {
    var isiPad: Bool {
        model.hasPrefix("iPad")
    }
}
