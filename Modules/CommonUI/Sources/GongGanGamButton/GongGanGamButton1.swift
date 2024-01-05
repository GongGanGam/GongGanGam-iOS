//
//  GongGanGamButton.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/01/29.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit

open class GongGanGamButton1: UIButton {
    
    public enum Style {
        case lightBackground
        case darkBackground
        case disabled
    }
    
    // MARK: - Properties
    open override var isEnabled: Bool {
        get {
            return super.isEnabled
        }
        set {
            super.isEnabled = newValue
            if !newValue {
                originStyle = style
                style = .disabled
            } else {
                style = originStyle
            }
        }
    }
    
    public var style: Style {
        didSet {
            updateStyle()
        }
    }
    
    private var originStyle: Style
    private var titleForStyle = [Style: String]()
    private var titleColorForStyle: [Style: UIColor] = [.lightBackground: GongGanGamUIAsset.primary.color,
                                                        .darkBackground: GongGanGamUIAsset.neutral10.color,
                                                        .disabled: GongGanGamUIAsset.neutral80.color]
    
    private var backgroundColorForStyle: [Style: UIColor] = [.lightBackground: GongGanGamUIAsset.neutral20.color,
                                                             .darkBackground: GongGanGamUIAsset.primary.color,
                                                             .disabled: GongGanGamUIAsset.neutral50.color]
    
    private var borderColorForStyle: [Style: UIColor] = [.darkBackground: GongGanGamUIAsset.neutral70.color]
    
    // MARK: - Initializers
    public init(style: Style = .lightBackground) {
        self.style = style
        self.originStyle = style
        
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 8
        self.titleLabel?.font = Pretendard.button1
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    open func setTitle(_ title: String?, forStyle style: Style) {
        titleForStyle[style] = title
        updateStyle()
    }
    
    open func setBackgroundColor(_ color: UIColor?, forStyle style: Style) {
        backgroundColorForStyle[style] = color
        updateStyle()
    }
    
    open func setBorderColorForStyle(_ color: UIColor?, forStyle style: Style) {
        borderColorForStyle[style] = color
        updateStyle()
    }
    
    private func updateStyle() {
        let title = titleForStyle[style]
        let titleColor = titleColorForStyle[style]
        let backgroundColor = backgroundColorForStyle[style]
        let borderColor = borderColorForStyle[style]
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        
        if let borderColor {
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = 1
        } else {
            self.layer.borderWidth = 0
        }
        self.setNeedsLayout()
    }
}

