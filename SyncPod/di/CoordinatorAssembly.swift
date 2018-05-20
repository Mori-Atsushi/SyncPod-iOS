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
    weak var delegate = UIApplication.shared.delegate as? AppDelegate

    func assemble(container: Container) {
        container.register(ApplicationCoordinator.self) { _ in
            return ApplicationCoordinator(window: (self.delegate?.window)!)
        }.inObjectScope(.container)

        container.register(WelcomeCoordinator.self) { _ in
            return WelcomeCoordinator(window: (self.delegate?.window)!)
        }.inObjectScope(.container)
    }
}
