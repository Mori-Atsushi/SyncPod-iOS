//
//  WelcomeCoordinator.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import SwinjectStoryboard

class WelcomeCoordinator: BaseCoordinator {
    weak var delegate = UIApplication.shared.delegate as? AppDelegate
    private let window: UIWindow
    private let storyboard: SwinjectStoryboard
    private var nowViewController: UIViewController

    init() {
        self.window = (delegate?.window)!
        self.storyboard = SwinjectStoryboard.create(name: "Welcome", bundle: nil)
        self.nowViewController = storyboard.instantiateViewController(withIdentifier: "WelcomeView")
    }

    func start() {
    }

    func navigateToSignIn() {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignInView")
        nowViewController.present(viewController, animated: true, completion: nil)
        nowViewController = viewController
    }

    func navigateToSignUp() {
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUpView")
        nowViewController.present(viewController, animated: true, completion: nil)
        nowViewController = viewController
    }
}
