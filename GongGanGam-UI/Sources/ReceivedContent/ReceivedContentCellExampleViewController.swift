//
//  ReceivedContentCellExampleViewController.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class ReceivedContentCellExampleViewController: UIViewController {
    
    // MARK: - UI
    private lazy var receivedContentCellCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(ReceivedContentCell.self, forCellWithReuseIdentifier: ReceivedContentCell.reuseIdentifier)
        collectionView.backgroundColor = GongGanGamUIAsset.background.color
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        return collectionView
    }()
    
    // MARK: - Properties
    private let flexContainer = UIView()
    
    // MARK: - Initializers
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GongGanGamUIAsset.background.color
        self.view.addSubview(flexContainer)
        
        flexContainer.flex.addItem(receivedContentCellCollectionView).grow(1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
    }
}

extension ReceivedContentCellExampleViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReceivedContentCell.reuseIdentifier,
                                                            for: indexPath) as? ReceivedContentCell else {
            return UICollectionViewCell()
        }
        
        var day = "\(indexPath.row)"
        if day.count == 1 {
            day = "0\(day)"
        }
        
        cell.configureCell(profileImage: UIImage(systemName: "\(indexPath.item).circle.fill"),
                           nickname: "nickname \(indexPath.item)",
                           isNewContent: indexPath.item <= 3,
                           date: "2023-01-\(day)",
                           content: "Content \(indexPath.item) of Cell \(indexPath.item)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 32
        return CGSize(width: width, height: 81)
    }
}
