//
//  RootFlow.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/03/16.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import UIKit
import RxFlow
import GongGanGam_Kit
import GongGanGam_Network
import TokenManager

final class RootFlow: Flow {
    
    // MARK: - Properties
    var root: Presentable {
        return rootViewController
    }
    
    private lazy var rootViewController: UIViewController = {
        let repository = UserSessionRepository(
            networkManager: NetworkManager(),
            tokenManager: KeychainTokenManager()
        )
        let viewModel = RootViewModel(repository: repository)
        let viewController = RootViewController(viewModel: viewModel)
        
        return viewController
    }()
    
    // MARK: - Initializer
    
    // MARK: - Methods
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? RootStep else { return .none }
        
        switch step {
        case .userSessionIsRequired:
            return navigateToSignInViewController()
            
        case .userIsSignedIn(let userSession):
            return navigateToSignedInViewController(with: userSession)
            
        case .onboardingIsRequired:
            return navigateToOnboardingViewController()
            
        case .onboardingIsComplete:
            return .end(forwardToParentFlowWithStep: step)
        }
    }
    
    private func navigateToRootViewController() -> FlowContributors {
        return .none
    }
    
    private func navigateToSignInViewController() -> FlowContributors {
        print(#function)
        return .none
    }
    
    private func navigateToOnboardingViewController() -> FlowContributors {
        print(#function)
        return .none
    }
    
    private func navigateToSignedInViewController(with userSession: UserSession) -> FlowContributors {
        print(#function)
        return .none
    }
}
