//
//  AlertBuilderExampleViewController.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/01/27.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

final class AlertBuilderExampleViewController: UIViewController {
    
    // MARK: - UI
    private lazy var alertsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    // MARK: - Properties
    private let flexContainer = UIView()
    private let alerts = [
        "Alert: 확인",
        "Alert: 확인 + 취소",
        "Alert: over 3 with destructive",
        "Action Sheet: 확인, 취소",
        "Action Sheet: over 3, 취소"
    ]
    
    // MARK: - Initializers
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(flexContainer)
        flexContainer.flex.addItem(alertsTableView).grow(1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        flexContainer.pin.all(flexContainer.pin.safeArea)
        flexContainer.flex.layout()
    }
}

extension AlertBuilderExampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = alerts[indexPath.row]
        
        cell.contentConfiguration = contentConfiguration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = alerts[indexPath.row]
        
        switch indexPath.row {
        case 0:
            let builder = AlertBuilder(title: "Alert", message: message)
            
            builder.appendingAction(title: "확인")
                .present(at: self)
        case 1:
            let builder = AlertBuilder(title: "Alert", message: message)
            
            builder.appendingAction(title: "확인")
                .appendingCancel()
                .present(at: self)
        case 2:
            let builder = AlertBuilder(title: "Alert", message: message)
            
            builder.appendingAction(title: "첫 번째")
                .appendingAction(title: "두 번째")
                .appendingDestructiveAction(title: "세 번째 (Destructive)")
                .appendingCancel()
                .present(at: self)
        case 3:
            let builder = AlertBuilder(title: "Action Sheet", message: message, preferredStyle: .actionSheet)
            
            builder.appendingAction(title: "확인")
                .appendingCancel()
                .present(at: self)
        case 4:
            let builder = AlertBuilder(title: "Action Sheet", message: message, preferredStyle: .actionSheet)
            
            builder.appendingAction(title: "첫 번째")
                .appendingAction(title: "두 번째")
                .appendingDestructiveAction(title: "세 번째 (Destructive)")
                .appendingCancel()
                .present(at: self)
        default:
            return
        }
    }
}
