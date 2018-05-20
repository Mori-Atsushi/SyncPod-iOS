//
//  AppDelegate.swift
//  SyncPod
//
//  Created by 森篤史 on 2017/11/25.
//  Copyright © 2017年 Cyder. All rights reserved.
//

import UIKit
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var assembler = Assembler([
        CoordinatorAssembly(),
        ViewModelAssembly(),
        ViewControllerAssembly()
        ])
    lazy var coordinator = assembler.resolver.resolve(ApplicationCoordinator.self)!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        coordinator.start()
        return true
    }

    func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplicationOpenURLOptionsKey: Any] = [:]
    ) -> Bool {
        coordinator.start()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}
