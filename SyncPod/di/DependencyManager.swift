//
//  DependencyManager.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/05/21.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class DependencyManager {
    static let assembler = Assembler([
        CoordinatorAssembly(),
        ViewModelAssembly(),
        ViewControllerAssembly()
        ], container: SwinjectStoryboard.defaultContainer)

    static func getResolver() -> Resolver {
        return assembler.resolver
    }
}
