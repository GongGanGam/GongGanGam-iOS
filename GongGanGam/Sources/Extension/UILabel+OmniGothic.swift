//
//  UIFont+OmniGothic.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/02/18.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import GongGanGam_UI

extension UILabel {
    
    func omniGothicRegular(ofSize size: CGFloat) {
        let font = GongGanGamUIFontFamily._210OmniGothic._030.font(size: size)
        applyOmniGothic(font)
    }
    
    func omniGothicBold(ofSize size: CGFloat) {
        let font = GongGanGamUIFontFamily._210OmniGothic._050.font(size: size)
        applyOmniGothic(font)
    }
    
    private func applyOmniGothic(_ font: UIFont) {
        self.font = font
    }
}
