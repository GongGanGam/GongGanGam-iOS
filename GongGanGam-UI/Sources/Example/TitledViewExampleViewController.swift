//
//  TitledViewExampleViewController.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/01/25.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class TitledViewExampleViewController: UIViewController {
    
    // MARK: - UI
    lazy var titledTextField: TitledTextField = {
        let view = TitledTextField()
        
        view.titleLabel.text = "테스트"
        view.textField.placeholder = "닉네임을 입력해 주세요."
        return view
    }()
    
    lazy var titledSegmentedControl: TitledSegmentedControl = {
        let view = TitledSegmentedControl()
        
        view.titleLabel.text = "테스트"
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    private let flexContainer = UIView()
    
    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GongGanGamUIAsset.background.color
        self.view.addSubview(flexContainer)
        
        flexContainer.flex.padding(12).addItem(titledSegmentedControl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexContainer.pin.all(self.view.pin.safeArea)
        flexContainer.flex.layout()
    }
}

extension TitledViewExampleViewController: TitledSegmentedControlDelegate, TitledSegmentedControlDataSource {
    
    func titledSegmentedControl(_ segmentedControl: TitledSegmentedControl, titleForItemAt index: Int) -> String {
        if index == 0 {
            return "남자"
        } else if index == 1 {
            return "여자"
        } else {
            return "선택하지 않음"
        }
    }
    
    func titledSegmentedControl(_ segmentedControl: TitledSegmentedControl, didSelectItemAt index: Int) {
        print(index)
    }
    
    func numberOfItems(_ segmentedControl: TitledSegmentedControl) -> Int {
        return 3
    }
}
