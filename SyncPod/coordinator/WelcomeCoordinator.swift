//
//  WelcomeCoordinator.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class WelcomeCoordinator: BaseCoordinator {
    private let window: UIWindow
    private let storyboard: UIStoryboard
    private var nowVC: UIViewController

    init(window: UIWindow) {
        self.window = window
        self.storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        self.nowVC = storyboard.instantiateViewController(withIdentifier: "WelcomeView")
        if let welcomeVC = nowVC as? WelcomeViewConstoller {
            var viewModel = WelcomeViewModel()
            viewModel.coordinator = self
            welcomeVC.viewModel = viewModel
        }
    }

    func start() {
        window.rootViewController = nowVC
    }

    func navigateToSignIn() {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignInView")
        nowVC.present(viewController, animated: true, completion: nil)
        nowVC = viewController
    }

    func navigateToSignUp() {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUpView")
        nowVC.present(viewController, animated: true, completion: nil)
        nowVC = viewController
    }
}
