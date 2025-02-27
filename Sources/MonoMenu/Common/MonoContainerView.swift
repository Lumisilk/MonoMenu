//
//  MonoContainerView.swift
//  MonoMenu
//
//  Created by lumisilk on 2024/12/08.
//

import UIKit

final class MonoContainerView: UIView {
    
    private let cornerRadius: CGFloat = 16
    
    private let shadowView = ShadowView()
    private var contentView: UIView!
    
    init(backgroundColor: UIColor = .clear) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        
        shadowView.bounds.size = bounds.size + CGSize(width: 300, height: 300)
        shadowView.center = bounds.center
        shadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(shadowView)
    }
    
    func setupContentView(_ contentView: UIView) {
        self.contentView = contentView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.cornerCurve = .continuous
        addSubview(contentView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
