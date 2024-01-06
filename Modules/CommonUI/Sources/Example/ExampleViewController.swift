//
//  ExampleViewController.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/01/25.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import FlexLayout
import PinLayout

public final class ExampleViewController: UIViewController {
    
    lazy var componentListTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let rootContainer = UIView()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init?(coder:) is called.")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "GongGanGam-UI"
        self.view.addSubview(rootContainer)
        
        rootContainer.flex.define { flex in
            flex.addItem(componentListTableView).grow(1)
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        rootContainer.pin.all()
        rootContainer.flex.layout()
    }
}

extension ExampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Components.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var contentConfiguration = cell.defaultContentConfiguration()
        
        contentConfiguration.text = Components.allCases[indexPath.row].rawValue
        cell.contentConfiguration = contentConfiguration
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let component = Components.allCases[indexPath.row]
        let vc = component.viewController
        
        vc.title = component.rawValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
