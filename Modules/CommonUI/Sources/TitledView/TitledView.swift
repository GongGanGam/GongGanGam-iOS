//
//  TitledView.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/25.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

/// The view which contains title and content.
///
/// ```
/// | [titleLabel]          |
/// | [    contentView    ] |
/// ```
open class TitledView: UIView {
    
    // MARK: - UI
    
    /// Title label of `TitledView`.
    /// Based on `UILabel`
    ///
    /// - default font: `Pretendard.Body(400)`
    /// - default textColor: `Neutral-10`
    ///
    /// 이 label의 `text`를 변경하여 `TitledView`의 타이틀을 설정할 수 있습니다.
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Pretendard.body
        label.textColor = GongGanGamUIAsset.neutral10.color
        return label
    }()
    
    // MARK: - Properties
    public let rootContainer = UIView()
    
    // MARK: - Initializers
    public init() {
        super.init(frame: .zero)
        
        self.addSubview(rootContainer)
        configureContainer()
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        rootContainer.pin.top().horizontally()
        rootContainer.flex.layout()
    }
    
    private func configureContainer() {
        rootContainer.flex.define { flex in
            flex.addItem(titleLabel)
        }
    }
}
