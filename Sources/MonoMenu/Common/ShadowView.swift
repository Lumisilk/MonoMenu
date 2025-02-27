//
//  ShadowView.swift
//  MonoMenu
//
//  Created by lumisilk on 2024/12/08.
//

import UIKit

final class ShadowView: UIImageView {
    init() {
        var shadow = UIImage(named: "shadow.png", in: .module, compatibleWith: nil)!
        let edge = shadow.size.width * 0.425
        let insets = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge)
        shadow = shadow.resizableImage(withCapInsets: insets, resizingMode: .stretch)
        super.init(image: shadow)
        alpha = 0.1
        isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
    }
}
