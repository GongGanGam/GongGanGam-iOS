//
//  ShadowProfileImageView.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

open class ShadowProfileImageView: UIView {
    
    // MARK: - UI
    private lazy var profileImageView: ProfileImageView = {
        let view = ProfileImageView()
        
        return view
    }()
    
    // MARK: - Properties
    public var image: UIImage? {
        get {
            return profileImageView.image
        }
        set {
            profileImageView.image = newValue
        }
    }
    
    private let flexContainer = UIView()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        
        self.addSubview(profileImageView)
        self.layer.shadowColor = GongGanGamUIAsset.shadow.color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = false
        
        self.addSubview(flexContainer)
        flexContainer.flex.addItem(profileImageView).grow(1)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
    }
}
