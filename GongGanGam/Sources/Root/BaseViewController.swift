//
//  BaseViewController.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/02/19.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    let baseContainer = UIView()
    
    // MARK: - Initializer
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWillConfigureLayout()
        configureLayout()
        bind()
    }
    
    func viewWillConfigureLayout() {}
    
    func configureLayout() {
        self.view.addSubview(baseContainer)
    }
    
    func bind() {}
}
