//
//  ChatPreviewCell.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

open class ChatPreviewCell: UITableViewCell {
    
    // MARK: - UI
    private lazy var profileImageView: ProfileImageView = {
        let view = ProfileImageView()
        
        return view
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        
        label.font = Pretendard.bodyBold
        label.textColor = GongGanGamUIAsset.neutral10.color
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .right
        label.font = Pretendard.caption2
        label.textColor = GongGanGamUIAsset.neutral40.color
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        
        label.font = Pretendard.body
        label.textColor = GongGanGamUIAsset.neutral40.color
        return label
    }()
    
    // MARK: - Properties
    public static var reuseIdentifier: String { return String(describing: Self.self) }
    private let flexContainer = UIView()
    
    // MARK: - Initializers
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.addSubview(flexContainer)
        flexContainer.flex.direction(.row).alignItems(.center).margin(16).define { flex in
            // profile
            flex.addItem(profileImageView).aspectRatio(1).width(40)
            
            // contents
            flex.addItem().direction(.column).grow(1).marginLeft(8).define { flex in
                // nickname + date
                flex.addItem().direction(.row).justifyContent(.spaceBetween).define { flex in
                    flex.addItem(nicknameLabel).grow(1)
                    flex.addItem(dateLabel).grow(1)
                }
                
                // content
                flex.addItem().marginTop(4).define { flex in
                    flex.addItem(contentLabel).grow(1)
                }
            }
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
    
    public func configureCell(profileImage: UIImage?,
                              nickname: String,
                              date: String,
                              content: String) {
        self.profileImageView.image = profileImage
        self.nicknameLabel.text = nickname
        self.dateLabel.text = date.replacingOccurrences(of: "-", with: ".")
        self.contentLabel.text = content
    }
}
