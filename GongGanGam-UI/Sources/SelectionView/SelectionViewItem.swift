//
//  SelectionViewItem.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/27.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

open class SelectionViewItem: UIButton {
    
    public enum State: CaseIterable {
        case normal
        case selected
        case deselected
    }
    
    // MARK: - UI
    
    /// `SelectionViewItem`의 이미지를 표시하는 `UIImageView`입니다.
    public lazy var selectionImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    /// `SelectionViewItem`의 타이틀을 표시하는 `UILabel`입니다.
    ///
    /// 기본 `font`는 `Pretendard.caption2Bold`입니다.
    /// 기본 `textColor`는 `Neutral40`입니다.
    public lazy var selectionTitleLabel: UILabel = {
        let label = UILabel()
        
        label.font = Pretendard.caption2Bold
        label.textColor = GongGanGamUIAsset.neutral40.color
        return label
    }()
    
    // MARK: - Properties
    
    /// `SelectionViewItem`의 상태를 의미합니다.
    public internal(set) var selectionState: State = .normal {
        didSet {
            configureView()
        }
    }
    
    internal var row: Int
    internal var column: Int
    
    private var imageForState = [State: UIImage]()
    private var titleForState = [State: String]()
    
    private let flexContainer = UIView()
    
    // MARK: - Initializers
    internal init(row: Int, column: Int) {
        self.row = row
        self.column = column
        
        super.init(frame: .zero)
        
        flexContainer.isUserInteractionEnabled = false
        self.addSubview(flexContainer)
        flexContainer.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(selectionImageView)
            flex.addItem(selectionTitleLabel).marginTop(8)
        }
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
    }
    
    /// `SelectionViewItem`의 상태에 따른 image를 설정합니다.
    ///
    /// - Parameters:
    ///   - image: 특정 `state`일 때 표시할 Image입니다. 다른 `state`가 설정되어 있지 않으면 `normal` state의 이미지를 사용합니다.
    ///   - state: `image`를 표시할 state입니다.
    open func setSelectionImage(_ image: UIImage?, for state: State) {
        imageForState[state] = image
        
        if selectionState == state {
            configureView()
        }
    }
    
    /// `SelectionViewItem`의 상태에 따른 title을 설정합니다.
    ///
    /// - Parameters:
    ///   - title: 특정 `state`일 때 표시할 Title입니다. 다른 `state`가 설정되어 있지 않으면 `normal` state의 타이틀을 사용합니다.
    ///   - state: `title`을 표시할 state입니다.
    open func setSelectionTitle(_ title: String?, for state: State) {
        titleForState[state] = title
        
        if selectionState == state {
            configureView()
        }
    }
    
    private func configureView() {
        let image = imageForState[selectionState] ?? imageForState[.normal]
        let title = titleForState[selectionState] ?? titleForState[.normal]
        
        selectionImageView.image = image
        selectionTitleLabel.text = title
    }
}
