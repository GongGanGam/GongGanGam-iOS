//
//  SelectionViewDelegate+DataSource.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/27.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit

public protocol SelectionViewDelegate: AnyObject {
    
    /**
     `SelectionView`에서 선택된 `row`와 `column`을 알려 주는 메서드입니다.
     
     - Parameters:
       - selectionView: 선택된 Item의 `SelectionView`입니다.
       - row: 선택된 Item의 Row입니다.
       - column: 선택된 Item의 Column입니다.
     
     `SelectionView`에서 Item을 선택했을 때 호출되는 델리게이트 메서드입니다.
     
     ```swift
     let data = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
     
     // when select 5 in data array
     func selectionView(_ selectionView: SelectionView, didSelectItemAtRow row: Int, column: Int) {
        print("\(row), \(column)") // prints 1, 1
     }
     ```
     */
    func selectionView(_ selectionView: SelectionView, didSelectItemAtRow row: Int, column: Int)
}

public protocol SelectionViewDataSource: AnyObject {
    
    /// `SelectionView`에 나타낼 Row의 개수를 반환하는 DataSource입니다.
    ///
    /// - Parameter selectionView: Row의 개수를 요청한 `SelectionView`입니다.
    /// - Returns: `selectionView`의 Row의 개수입니다.
    func numberOfRows(in selectionView: SelectionView) -> Int
    
    /// `SelectionView`에 나타낼 Column의 개수를 반환하는 DataSource입니다.
    ///
    /// - Parameter selectionView: Column의 개수를 요청한 `SelectionView`입니다.
    /// - Returns: `selectionView`의 Column의 개수입니다.
    func numberOfColumns(in selectionView: SelectionView) -> Int
    
    /// `SelectionView`의 `row`, `column`에 해당하는 Item에 들어갈 이미지를 반환합니다.
    ///
    /// - Parameters:
    ///   - selectionView: Item이 속한 `SelectionView`입니다.
    ///   - row: Item의 row입니다.
    ///   - column: Item의 column입니다.
    ///   - state: Item의 state입니다. `SelectionViewItem.State` 타입입니다.
    /// - Returns: Item에 들어갈 `UIImage`를 반환합니다.
    func selectionView(_ selectionView: SelectionView, imageForItemAtRow row: Int, column: Int, for state: SelectionViewItem.State) -> UIImage?
    
    /// `SelectionView`의 `row`, `column`에 해당하는 Item에 들어갈 텍스트를 반환합니다.
    ///
    /// - Parameters:
    ///   - selectionView: Item이 속한 `SelectionView`입니다.
    ///   - row: Item의 row입니다.
    ///   - column: Item의 column입니다.
    ///   - state: Item의 state입니다. `SelectionViewItem.State` 타입입니다.
    /// - Returns: Item에 들어갈 텍스트를 반환합니다.
    func selectionView(_ selectionView: SelectionView, titleForItemAtRow row: Int, column: Int, for state: SelectionViewItem.State) -> String?
}
