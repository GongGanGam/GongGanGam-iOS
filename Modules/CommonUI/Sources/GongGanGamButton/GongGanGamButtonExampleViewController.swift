//
//  GongGanGamButtonExampleViewController.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/29.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class GongGanGamButtonExampleViewController: UIViewController {
    
    // MARK: - UI
    private lazy var gongGanGamButton: GongGanGamButton = {
        let button = GongGanGamButton()
        
        button.setTitle("Light Background", forStyle: .lightBackground)
        button.setTitle("Dark Background", forStyle: .darkBackground)
        button.setTitle("Disabled", forStyle: .disabled)
        button.addTarget(self, action: #selector(styleButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var initializeButton: GongGanGamButton = {
        let button = GongGanGamButton()
        
        button.setTitle("Reset button status", forStyle: .lightBackground)
        button.addTarget(self, action: #selector(initializeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    private let flexContainer = UIView()
    
    // MARK: - Initializers
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GongGanGamUIAsset.background.color
        self.view.addSubview(flexContainer)
        flexContainer.flex.padding(16).define { flex in
            flex.addItem(gongGanGamButton).height(50)
            flex.addItem(initializeButton).marginTop(36).height(50)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexContainer.pin.all(self.view.pin.safeArea)
        flexContainer.flex.layout()
    }
    
    @objc private func styleButtonTapped(_ sender: GongGanGamButton) {
        if sender.style == .lightBackground {
            sender.style = .darkBackground
        } else if sender.style == .darkBackground {
            sender.isEnabled = false
        } else {
            print("Has error if you show this message. GongGanGamButton.isEnabled is not working.")
        }
    }
    
    @objc private func initializeButtonTapped() {
        gongGanGamButton.isEnabled = true
        gongGanGamButton.style = .lightBackground
    }
}
