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
    
    lazy var titledPickerView: TitledPickerView = {
        let view = TitledPickerView()
        
        view.titleLabel.text = "테스트-DatePicker"
        view.placeholder = "출생년도를 선택해주세요."
        view.pickerView.delegate = self
        view.pickerView.dataSource = self
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
        
        flexContainer.flex.padding(12).define { flex in
            flex.addItem(titledTextField)
            flex.addItem(titledPickerView).marginTop(24)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexContainer.pin.all(self.view.pin.safeArea)
        flexContainer.flex.layout()
    }
}

extension TitledViewExampleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 50
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1980)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        titledPickerView.text = "\(row + 1980)"
    }
}
