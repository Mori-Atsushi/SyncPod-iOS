//
//  ViewControllerAssembly.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Swinject

class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WelcomeViewConstoller.self) { _ in
            return WelcomeViewConstoller()
        }
    }
}
