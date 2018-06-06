//
//  ViewControllerAssembly.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        container.storyboardInitCompleted(WelcomeViewConstoller.self) { res, viewController in
            viewController.viewModel = res.resolve(WelcomeViewModel.self)!
        }
    }
}
