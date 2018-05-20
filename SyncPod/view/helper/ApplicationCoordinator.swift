//
//  ApplicationCoordinator.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class ApplicationCoordinator {
    private let window: UIWindow
    private var nowVC: UIViewController?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "WelcomeView")
        if let welcomeVC = viewController as? WelcomeViewConstoller {
            var viewModel = WelcomeViewModel()
            viewModel.coordinator = self
            welcomeVC.viewModel = viewModel
        }
        window.rootViewController = viewController
        nowVC = viewController
    }

    func navigateToSignIn() {
        let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignInView")
        nowVC?.present(viewController, animated: true, completion: nil)
    }

    func navigateToSignUp() {
        let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUpView")
        nowVC?.present(viewController, animated: true, completion: nil)
    }
}
