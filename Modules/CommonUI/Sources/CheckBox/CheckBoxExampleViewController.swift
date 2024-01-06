//
//  CheckBoxExampleViewController.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/28.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class CheckBoxExampleViewController: UIViewController {
    
    // MARK: - UI
    private lazy var checkBox: CheckBox = {
        let checkBox = CheckBox(title: "일기 공유하기")
        
        return checkBox
    }()
    
    private lazy var checkedStatusLabel: UILabel = {
        let label = UILabel()
        
        label.text = "press checkBox"
        return label
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
        flexContainer.flex.alignItems(.center).define { flex in
            flex.addItem(checkBox)
            flex.addItem(checkedStatusLabel).marginTop(32)
        }
        
        checkBox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexContainer.pin.all(self.view.pin.safeArea)
        flexContainer.flex.layout()
    }
    
    @objc func checkBoxTapped(_ sender: CheckBox) {
        checkedStatusLabel.text = "isChecked: \(sender.isChecked)"
        checkedStatusLabel.sizeToFit()
    }
}
