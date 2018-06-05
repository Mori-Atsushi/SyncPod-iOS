//
//  ApplicationCoordinator.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class ApplicationCoordinator: BaseCoordinator {
    private let window: UIWindow
    private let welcomeCoordinator: WelcomeCoordinator

    init(window: UIWindow) {
        self.window = window
        self.welcomeCoordinator = WelcomeCoordinator(window: window)
    }

    func start() {
        welcomeCoordinator.start()
    }
}
