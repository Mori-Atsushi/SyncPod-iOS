//
//  CoordinatorAssembly.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import Swinject

class CoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ApplicationCoordinator.self) { res in
            ApplicationCoordinator(
                welcomeCoordinator: res.resolve(WelcomeCoordinator.self)!
            )
        }.inObjectScope(.container)

        container.register(WelcomeCoordinator.self) { _ in
            WelcomeCoordinator()
        }.inObjectScope(.container)
    }
}
