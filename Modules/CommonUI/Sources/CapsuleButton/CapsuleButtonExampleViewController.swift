//
//  CapsuleButtonExampleViewController.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/29.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class CapsuleButtonExampleViewController: UIViewController {
    
    // MARK: - UI
    private lazy var capsuleButton: CapsuleButton = {
        let button = CapsuleButton(title: "Example")
        
        return button
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
        
        self.view.backgroundColor = GongGanGamUIAsset.background.color
        self.view.addSubview(flexContainer)
        flexContainer.flex.addItem(capsuleButton).height(30).margin(24)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexContainer.pin.all(self.view.pin.safeArea)
        flexContainer.flex.layout()
    }
}
