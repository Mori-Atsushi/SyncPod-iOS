//
//  ApplicationCoordinator.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class ApplicationCoordinator: BaseCoordinator {
    private let welcomeCoordinator: WelcomeCoordinator

    init(welcomeCoordinator: WelcomeCoordinator) {
        self.welcomeCoordinator = welcomeCoordinator
    }

    func start() {
        welcomeCoordinator.start()
    }
}
