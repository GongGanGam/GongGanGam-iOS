//
//  SelectionView.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/01/27.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

/**
 여러 Item 중 하나를 선택할 수 있는 View입니다.
 
 - `SelectionViewDataSource`
   - Row와 Column의 개수를 반환합니다.
   - 각 Row와 Column에 해당하는 Item의 이미지와 타이틀을 반환합니다.
   - 자세한 내용은 ``SelectionViewDataSource``를 참고해주세요.
 
 - `SelectionViewDelegate`
   - Item이 선택되었을 때, 선택된 Item의 Row와 Column을 알려줍니다.
   - 자세한 내용은 ``SelectionViewDelegate``를 참고해주세요.
 */
open class SelectionView: UIView {
    
    // MARK: - UI
    
    // MARK: - Properties
    
    /// `SelectionView`의 Delegate 입니다.
    public weak var delegate: SelectionViewDelegate?
    
    /// `SelectionView`의 DataSource입니다.
    public weak var dataSource: SelectionViewDataSource?
    
    private let flexContainer = UIView()
    private var selectionViewItems = [[SelectionViewItem]]()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        
        self.addSubview(flexContainer)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        configureSelectionViewItems()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
    }
    
    private func configureSelectionViewItems() {
        guard let dataSource else { return }
        
        let rows = dataSource.numberOfRows(in: self)
        selectionViewItems = []
        
        flexContainer.flex.define { flex in
            (0..<rows).forEach { row in
                flex.addItem().direction(.row)
                    .alignItems(.center)
                    .grow(1)
                    .define { flex in
                        let selectionViewItemRow = self.makeSelectionViewItemRow(row: row)
                        self.selectionViewItems.append(selectionViewItemRow)
                        
                        selectionViewItemRow.forEach { item in
                            flex.addItem(item).grow(1)
                        }
                    }
            }
        }
    }
    
    private func makeSelectionViewItemRow(row: Int) -> [SelectionViewItem] {
        guard let dataSource else { return [] }
        
        let columns = dataSource.numberOfColumns(in: self)
        
        return (0..<columns).compactMap { [weak self] column in
            return self?.makeSelectionViewItem(atRow: row, column: column)
        }
    }
    
    private func makeSelectionViewItem(atRow row: Int, column: Int) -> SelectionViewItem {
        let item = SelectionViewItem(row: row, column: column)
        
        for state in SelectionViewItem.State.allCases {
            let image = dataSource?.selectionView(self, imageForItemAtRow: row, column: column, for: state)
            let title = dataSource?.selectionView(self, titleForItemAtRow: row, column: column, for: state)
            
            item.setSelectionImage(image, for: state)
            item.setSelectionTitle(title, for: state)
        }
        item.addTarget(self, action: #selector(itemTapped), for: .touchUpInside)
        
        return item
    }
    
    @objc private func itemTapped(_ sender: SelectionViewItem) {
        selectionViewItems.forEach {
            $0.forEach { selectionViewItem in
                selectionViewItem.selectionState = .deselected
            }
        }
        
        selectionViewItems[sender.row][sender.column].selectionState = .selected
        
        delegate?.selectionView(self, didSelectItemAtRow: sender.row, column: sender.column)
    }
}
