//
//  RootViewController.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/02/19.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout
import GongGanGam_UI

final class RootViewController: BaseViewController {
    
    // MARK: - UI
    private lazy var launchScreenImageView: UIImageView = {
        let imageView = UIImageView(image: GongGanGamAsset.splash.image)
        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        indicator.color = GongGanGamUIAsset.neutral10.color
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: - Properties
    private let viewModel: RootViewModel
    
    // MARK: - Initializer
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchUserSession()
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        baseContainer.flex
            .addItem(launchScreenImageView)
            .grow(1)
            .define { flex in
                flex.addItem(indicator)
                    .position(.relative)
                    .top(70%)
            }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        baseContainer.pin.all()
        baseContainer.flex.layout()
    }
}
