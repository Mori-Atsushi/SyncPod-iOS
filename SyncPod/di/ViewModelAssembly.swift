//
//  ViewModelAssembly.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(WelcomeViewModel.self) { res in
            WelcomeViewModel(
                coordinator: res.resolve(WelcomeCoordinator.self)!
            )
        }.inObjectScope(.container)
    }
}
