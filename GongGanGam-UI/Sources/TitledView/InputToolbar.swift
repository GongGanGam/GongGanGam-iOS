//
//  InputToolbar.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit

final class InputToolbar: UIToolbar {
    
    // MARK: - UI
    private lazy var doneButtonItem: UIBarButtonItem = {
        let item = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: action)
        
        return item
    }()
    
    // MARK: - Properties
    private let target: Any?
    private let action: Selector?
    
    // MARK: - Initializers
    init(target: Any?, action: Selector?) {
        self.target = target
        self.action = action
        
        super.init(frame: .zero)
        
        self.sizeToFit()
        self.setItems([.flexibleSpace(), doneButtonItem], animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    @objc private func doneButtonTapped() {
        self.endEditing(true)
    }
}
