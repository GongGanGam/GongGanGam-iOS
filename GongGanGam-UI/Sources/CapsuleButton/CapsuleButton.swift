//
//  CapsuleButton.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/29.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

open class CapsuleButton: UIButton {
    
    // MARK: - UI
    
    // MARK: - Properties
    
    // MARK: - Initializers
    public init(title: String) {
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = Pretendard.caption1
        self.titleLabel?.textColor = GongGanGamUIAsset.neutral40.color
        self.layer.borderWidth = 1
        self.layer.borderColor = GongGanGamUIAsset.neutral70.color.cgColor
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        let cornerRadius = min(self.frame.width, self.frame.height) / 2
        self.layer.cornerRadius = cornerRadius
    }
}
