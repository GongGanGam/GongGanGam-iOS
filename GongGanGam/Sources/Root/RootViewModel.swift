//
//  RootViewModel.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/03/14.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import ReactorKit
import RxRelay
import RxFlow
import GongGanGam_Kit

class RootViewModel: Stepper {
    
    // MARK: - Dependencies
    private let repository: UserSessionRepositoryProtocol
    private let disposeBag = DisposeBag()
    
    let steps = PublishRelay<Step>()
    
    init(repository: UserSessionRepositoryProtocol) {
        self.repository = repository
    }
    
    // MARK: - Reactor
    func fetchUserSession() {
        repository.fetch()
            .subscribe(
                onSuccess: { [weak steps] userSession in
                    if let userSession {
                        steps?.accept(RootStep.userIsSignedIn(userSession))
                    } else {
                        steps?.accept(RootStep.userSessionIsRequired)
                    }
                },
                onFailure: { error in
                    print(error)
                }
            )
            .disposed(by: disposeBag)
    }
}
