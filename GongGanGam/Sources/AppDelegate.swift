//
//  AppDelegate.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/01/02.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import RxSwift
import RxFlow
import GongGanGam_Kit
import GongGanGam_Network
import TokenManager

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let disposeBag = DisposeBag()
    let coordinator = FlowCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let appFlow = RootFlow()
        self.coordinator.coordinate(flow: appFlow)

        Flows.use(appFlow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }
        
        return true
    }
}
