//
//  AlertBuilder.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/01/27.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit

/**
 UIAlertController를 Builder 패턴으로 생성할 수 있는 객체입니다.
 
 ```swift
 AlertBuilder(title: "Title", message: "Message", preferredStyle: .alert)
    .appendingAction(title: "some title", style: .default, handler: someFunction)
    .appendingDestructiveAction(title: "somt title")
    .appendingCancel()
    .present(at: someViewController)
 ```
 
 ```swift
 let builder = AlertBuilder(title: "Title", message: "Message", preferredStyle: .alert)
 
 builder.appendingAction(title: "some title", style: .default, handler: someFunction)
    .appendingDestructiveAction(title: "somt title")
    .appendingCancel()
    .present(at: someViewController)
 ```
 */
public final class AlertBuilder {
    
    // MARK: - Properties
    private var alertActions: [UIAlertAction]
    private var title: String?
    private var message: String?
    private var preferredStyle: UIAlertController.Style
    
    // MARK: - Initializers
    public init(alertActions: [UIAlertAction] = [],
                title: String?,
                message: String?,
                preferredStyle: UIAlertController.Style = .alert) {
        self.alertActions = alertActions
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
    }
    
    // MARK: - Methods
    public func appendingAction(title: String,
                                style: UIAlertAction.Style = .default,
                                handler: (() -> Void)? = nil) -> AlertBuilder {
        let alertAction = UIAlertAction(title: title, style: style) { _ in handler?() }
        
        alertActions.append(alertAction)
        return self
    }
    
    public func appendingDestructiveAction(title: String,
                                           handler: (() -> Void)? = nil) -> AlertBuilder {
        return self.appendingAction(title: title, style: .destructive, handler: handler)
    }
    
    public func appendingCancel() -> AlertBuilder {
        return self.appendingAction(title: "취소", style: .cancel, handler: nil)
    }
    
    public func present(at viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        alertActions.forEach(alertController.addAction)
        
        viewController.present(alertController, animated: true)
    }
}
