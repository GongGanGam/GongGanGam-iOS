//
//  TitledSegmentedControlDelegate+DataSource.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

public protocol TitledSegmentedControlDelegate: AnyObject {
    
    func titledSegmentedControl(_ segmentedControl: TitledSegmentedControl, didSelectItemAt index: Int)
}

public protocol TitledSegmentedControlDataSource: AnyObject {
    
    func numberOfItems(_ segmentedControl: TitledSegmentedControl) -> Int
    func titledSegmentedControl(_ segmentedControl: TitledSegmentedControl, titleForItemAt index: Int) -> String
}
