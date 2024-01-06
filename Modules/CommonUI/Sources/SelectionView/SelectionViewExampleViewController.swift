//
//  SelectionViewExampleViewController.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/28.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class SelectionViewExampleViewController: UIViewController {
    
    private enum Emotion: String, CaseIterable {
        case happy, funny, exciting
        case soso, boring, angry
        case annoying, sad, depressed
        case embarrassing, complex, curious
        
        var image: UIImage? {
            let bundle = Bundle(for: SelectionView.self)
            
            return UIImage(named: self.rawValue, in: bundle, compatibleWith: nil)
        }
        
        var disabledImage: UIImage? {
            let bundle = Bundle(for: SelectionView.self)
            
            return UIImage(named: self.rawValue + "_disabled", in: bundle, compatibleWith: nil)
        }
        
        var title: String {
            switch self {
            case .happy:
                return "행복해요"
            case .funny:
                return "즐거워요"
            case .exciting:
                return "설레요"
            case .soso:
                return "그냥그래요"
            case .boring:
                return "지루해요"
            case .angry:
                return "화나요"
            case .annoying:
                return "짜증나요"
            case .sad:
                return "슬퍼요"
            case .depressed:
                return "우울해요"
            case .embarrassing:
                return "창피해요"
            case .complex:
                return "복잡해요"
            case .curious:
                return "궁금해요"
            }
        }
    }
    
    // MARK: - UI
    private lazy var selectionView: SelectionView = {
        let selectionView = SelectionView()
        
        selectionView.delegate = self
        selectionView.dataSource = self
        return selectionView
    }()
    
    // MARK: - Properties
    let flexContainer = UIView()
    
    // MARK: - Initializers
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GongGanGamUIAsset.background.color
        self.view.addSubview(flexContainer)
        flexContainer.flex.grow(1).padding(32).define { flex in
            flex.addItem(selectionView).grow(1)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexContainer.pin.all(self.view.pin.safeArea)
        flexContainer.flex.layout()
    }
}

extension SelectionViewExampleViewController: SelectionViewDelegate, SelectionViewDataSource {
    
    func numberOfRows(in selectionView: SelectionView) -> Int {
        return 4
    }
    
    func numberOfColumns(in selectionView: SelectionView) -> Int {
        return 3
    }
    
    func selectionView(_ selectionView: SelectionView, imageForItemAtRow row: Int, column: Int, for state: SelectionViewItem.State) -> UIImage? {
        let emotion = Emotion.allCases[row * 3 + column]
        switch state {
        case .normal, .selected:
            return emotion.image
        case .deselected:
            return emotion.disabledImage
        }
    }
    
    func selectionView(_ selectionView: SelectionView, titleForItemAtRow row: Int, column: Int, for state: SelectionViewItem.State) -> String? {
        let emotion = Emotion.allCases[row * 3 + column]
        
        return emotion.title
    }
    
    func selectionView(_ selectionView: SelectionView, didSelectItemAtRow row: Int, column: Int) {
        print("\(row), \(column)")
    }
}
