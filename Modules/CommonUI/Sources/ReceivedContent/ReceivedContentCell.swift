//
//  ReceivedContentCell.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

open class ReceivedContentCell: UICollectionViewCell {
    
    // MARK: - UI
    private lazy var profileImageView: ProfileImageView = {
        let view = ProfileImageView()
        
        return view
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        
        label.font = Pretendard.caption1Bold
        label.textColor = GongGanGamUIAsset.neutral10.color
        return label
    }()
    
    private lazy var badgeImageView: UIImageView = {
        let imageView = UIImageView(image: GongGanGamUIAsset.newBadge.image)
        
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.font = Pretendard.caption2
        label.textColor = GongGanGamUIAsset.neutral40.color
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        
        label.font = Pretendard.body
        label.textColor = GongGanGamUIAsset.neutral10.color
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Properties
    public static var reuseIdentifier: String { return String(describing: Self.self) }
    private let flexContainer = UIView()
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(flexContainer)
        configureFlexContainer()
        
        self.contentView.layer.borderColor = GongGanGamUIAsset.neutral70.color.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.backgroundColor = GongGanGamUIAsset.neutral90.color
        self.contentView.layer.cornerRadius = 8
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
                              isNewContent: Bool,
                              date: String,
                              content: String) {
        self.profileImageView.image = profileImage
        self.nicknameLabel.text = nickname
        self.dateLabel.text = date.replacingOccurrences(of: "-", with: ".")
        self.contentLabel.text = content
        self.badgeImageView.isHidden = !isNewContent
    }
}

// MARK: - Privates
private extension ReceivedContentCell {
    
    func configureFlexContainer() {
        flexContainer.flex.direction(.column).margin(16).define { flex in
            // top contents
            flex.addItem().alignItems(.center).direction(.row).define { flex in
                flex.define { flex in
                    flex.addItem(profileImageView).aspectRatio(1).width(20)
                    flex.addItem(nicknameLabel).marginLeft(8)
                    flex.addItem(badgeImageView).aspectRatio(1).width(16).marginLeft(8)
                }
                
                flex.addItem().grow(1)
                
                flex.define { flex in
                    flex.addItem(dateLabel)
                }
            }
            
            // content label
            flex.addItem(contentLabel).marginTop(8).grow(1)
        }
    }
}
