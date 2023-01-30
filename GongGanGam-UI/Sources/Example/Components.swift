//
//  Components.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/01/25.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit

internal enum Components: String, CaseIterable {
    
    case titledView
    case alertBuilder
    case selectionView
    case capsuleButton
    case checkbox
    case gongGanGamButton
    case profileImageView
    case receivedContentCell
    
    var viewController: UIViewController {
        switch self {
        case .titledView:
            return TitledViewExampleViewController()
        case .alertBuilder:
            return AlertBuilderExampleViewController()
        case .gongGanGamButton:
            return GongGanGamButtonExampleViewController()
        case .checkbox:
            return CheckBoxExampleViewController()
        case .selectionView:
            return SelectionViewExampleViewController()
        case .capsuleButton:
            return CapsuleButtonExampleViewController()
        case .profileImageView:
            return ProfileImageExampleViewController()
        case .receivedContentCell:
            return ReceivedContentCellExampleViewController()
        }
    }
}
