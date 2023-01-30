//
//  ProfileImageViewExampleViewController.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class ProfileImageExampleViewController: UIViewController {
    
    // MARK: - UI
    private lazy var profileImageView: ProfileImageView = {
        let view = ProfileImageView()
        
        view.image = GongGanGamUIAsset.profileImage.image
        return view
    }()
    
    private lazy var shadowProfileImageView: ShadowProfileImageView = {
        let view = ShadowProfileImageView()
        
        view.image = GongGanGamUIAsset.exciting.image
        return view
    }()
    
    // MARK: - Properties
    private let flexContainer = UIView()
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GongGanGamUIAsset.secondary.color
        self.view.addSubview(flexContainer)
        flexContainer.flex.alignItems(.center).define { flex in
            flex.addItem(profileImageView).aspectRatio(1).width(50)
            flex.addItem(shadowProfileImageView).aspectRatio(1).width(50).marginTop(50)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexContainer.pin.all(self.view.pin.safeArea)
        flexContainer.flex.layout()
    }
}
