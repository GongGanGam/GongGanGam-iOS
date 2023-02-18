//
//  TitledSegmentedControl.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

open class TitledSegmentedControl: TitledView {
    
    // MARK: - UI
    public lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Pretendard.caption1
        label.textColor = GongGanGamUIAsset.neutral40.color
        return label
    }()
    
    // MARK: - Properties
    private let container = UIView()
    private var items = [UIButton]()
    private var subtitle: String?
    
    /// 현재 선택된 Item의 index를 나타냅니다.
    public private(set) var selectedIndex: Int?
    
    /// `TitledSegmentedControl`의 이벤트를 수신할 수 있는 Delegate입니다.
    public weak var delegate: TitledSegmentedControlDelegate?
    
    /// `TitledSegmentedControl`의 데이터를 구성할 수 있는 DataSource입니다.
    public weak var dataSource: TitledSegmentedControlDataSource? {
        didSet {
            configureSegmentedItems()
        }
    }
    
    /// 선택되지 않은 Item의 테두리 색상을 나타냅니다. 기본으로 `Neutral70`을 가집니다.
    public var deselectedBorderColor: UIColor = GongGanGamUIAsset.neutral70.color
    
    /// 선택된 Item의 테두리 색상을 나타냅니다. 기본으로 `Neutral10`을 가집니다.
    public var selectedBorderColor: UIColor = GongGanGamUIAsset.neutral10.color
    
    /// 선택되지 않은 Item의 글자 색상을 나타냅니다. 기본으로 `Neutral40`을 가집니다.
    public var deselectedTextColor: UIColor = GongGanGamUIAsset.neutral40.color
    
    /// 선택된 Item의 글자 색상을 나타냅니다. 기본으로 `Neutral10`을 가집니다.
    public var selectedTextColor: UIColor = GongGanGamUIAsset.neutral10.color
    
    // MARK: - Initializers
    
    /// `TitledSegmentedControl`을 생성합니다.
    ///
    /// - Parameters:
    ///   - subtitle: 부가 설명을 나타냅니다. `nil`일 경우 subtitle을 표시하지 않고, `nil`이 아닐 경우 subtitle을 표시합니다.
    public init(subtitle: String? = nil) {
        self.subtitle = subtitle
        
        super.init()
    }
    
    // MARK: - Methods
    private func makeSegmentedItem(at index: Int) -> UIButton? {
        guard let title = dataSource?.titledSegmentedControl(self, titleForItemAt: index) else { return nil }
        let button = UIButton()
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(deselectedTextColor, for: .normal)
        button.titleLabel?.font = Pretendard.body
        button.layer.borderColor = deselectedBorderColor.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 18
        button.tag = index
        button.addTarget(self, action: #selector(itemTapped), for: .touchUpInside)
        return button
    }
    
    private func configureSegmentedItems() {
        guard let dataSource else { return }
        
        let numberOfItems = dataSource.numberOfItems(self)
        (0..<numberOfItems).forEach { index in
            if let item = makeSegmentedItem(at: index) {
                items.append(item)
            }
        }
        
        if let subtitle {
            subtitleLabel.text = subtitle
            self.rootContainer.flex.addItem(subtitleLabel).marginTop(8)
        }
        
        self.rootContainer.flex.addItem(container)
            .direction(.row)
            .marginTop(8)
            .define { flex in
                items.enumerated().forEach { (index, item) in
                    let margin = (index == 0) ? 0 : 8.0
                    flex.addItem(item).height(36).grow(1).marginLeft(margin)
                }
            }
    }
}

// MARK: - Privates
private extension TitledSegmentedControl {
    
    @objc func itemTapped(_ sender: UIButton) {
        delegate?.titledSegmentedControl(self, didSelectItemAt: sender.tag)
        
        if let selectedIndex {
            deselectItem(items[selectedIndex])
        }
        selectItem(items[sender.tag])
        selectedIndex = sender.tag
    }
    
    func deselectItem(_ button: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            button.layer.borderColor = self.deselectedBorderColor.cgColor
            button.setTitleColor(self.deselectedTextColor, for: .normal)
        })
    }
    
    func selectItem(_ button: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            button.layer.borderColor = self.selectedBorderColor.cgColor
            button.setTitleColor(self.selectedTextColor, for: .normal)
        })
    }
}
