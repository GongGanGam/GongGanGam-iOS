//
//  UIView+.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/02/18.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import GongGanGam_UI

extension UIView {
    
    func setGradientBackground() {
        let gradientLayer = CAGradientLayer()
        let startColor = GongGanGamUIAsset.secondary.color
        let endColor = GongGanGamUIAsset.background.color
        
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }
    
    func setBackground() {
        self.backgroundColor = GongGanGamUIAsset.background.color
    }
}
