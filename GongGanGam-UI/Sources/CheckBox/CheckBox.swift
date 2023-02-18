//
//  CheckBox.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/01/28.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

open class CheckBox: UIButton {
    
    // MARK: - UI
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = Pretendard.body
        label.textColor = GongGanGamUIAsset.neutral30.color
        return label
    }()
    
    private lazy var checkBoxImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = GongGanGamUIAsset.checkOff.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Properties
    private let flexContainer = UIView()
    
    /// `CheckBox`의 선택 여부를 나타냅니다.
    public var isChecked: Bool = false {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Initializers
    public init(title: String) {
        super.init(frame: .zero)
        
        descriptionLabel.text = title
        self.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        
        self.addSubview(flexContainer)
        flexContainer.isUserInteractionEnabled = false
        flexContainer.flex.direction(.row).define { flex in
            flex.addItem(descriptionLabel)
            flex.addItem(checkBoxImageView).marginLeft(4).aspectRatio(1).width(24)
        }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
    }
    
    /// Only `isChecked didSet` can call this method.
    private func updateState() {
        let image = isChecked ? GongGanGamUIAsset.checkOn : GongGanGamUIAsset.checkOff
        
        checkBoxImageView.image = image.image
    }
    
    @objc private func checkBoxTapped() {
        isChecked.toggle()
    }
}
