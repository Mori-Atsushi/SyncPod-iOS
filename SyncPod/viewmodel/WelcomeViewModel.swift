//
//  WelcomeViewModel.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation

class WelcomeViewModel {
    let coordinator: WelcomeCoordinator

    init(coordinator: WelcomeCoordinator) {
        self.coordinator = coordinator
    }
    func onSignInClicked() {
        coordinator.navigateToSignIn()
    }

    func onSignUpClicked() {
        coordinator.navigateToSignUp()
    }
}
