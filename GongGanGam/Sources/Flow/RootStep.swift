//
//  RootStep.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/03/16.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import RxFlow
import GongGanGam_Kit

enum RootStep: Step {
    
    // sign in
    case userSessionIsRequired
    case userIsSignedIn(UserSession)
    
    // onboarding
    case onboardingIsRequired
    case onboardingIsComplete
}
