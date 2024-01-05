//
//  ChatPreviewCellExampleViewController.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class ChatPreviewCellExampleViewController: UIViewController {
    
    // MARK: - UI
    private lazy var chatPreviewTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.separatorColor = GongGanGamUIAsset.neutral80.color
        
        tableView.register(ChatPreviewCell.self, forCellReuseIdentifier: ChatPreviewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    // MARK: - Properties
    private let flexContainer = UIView()
    
    // MARK: - Initializers
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GongGanGamUIAsset.background.color
        self.view.addSubview(flexContainer)
        
        flexContainer.flex.addItem(chatPreviewTableView).grow(1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexContainer.pin.all()
        flexContainer.flex.layout()
    }
}

extension ChatPreviewCellExampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatPreviewCell.reuseIdentifier,
                                                       for: indexPath) as? ChatPreviewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(profileImage: UIImage(systemName: "\(indexPath.row % 10).circle.fill"),
                           nickname: "Nickname \(indexPath.row)",
                           date: "2023-01-\(indexPath.row)",
                           content: "Content \(indexPath.row) of Cell \(indexPath.row)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
}
