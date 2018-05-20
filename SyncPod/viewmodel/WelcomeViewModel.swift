//
//  WelcomeViewModel.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation

struct WelcomeViewModel {
    var coordinator: WelcomeCoordinator?

    func onSignInClicked() {
        coordinator?.navigateToSignIn()
    }

    func onSignUpClicked() {
        coordinator?.navigateToSignUp()
    }
}
