//
//  ProfileImageView.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

open class ProfileImageView: UIImageView {
    
    // MARK: - UI
    
    // MARK: - Properties
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        
        self.contentMode = .scaleAspectFill
        self.layer.borderWidth = 1
        self.layer.borderColor = GongGanGamUIAsset.neutral40.color.cgColor
        self.clipsToBounds = true
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height / 2
    }
}
