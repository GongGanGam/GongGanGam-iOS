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
    
    var viewController: UIViewController {
        switch self {
        case .titledView:
            return TitledViewExampleViewController()
        case.alertBuilder:
            return AlertBuilderExampleViewController()
        }
    }
}
