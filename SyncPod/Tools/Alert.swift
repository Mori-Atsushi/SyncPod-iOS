//
//  Alert.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class ErrorAlart {
    let alert: UIAlertController;
    let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
    var viewController: UIViewController

    init(viewController: UIViewController, title: String, message: String) {
        self.viewController = viewController
        alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(defaultAction)
    }

    func show() {
        viewController.present(alert, animated: true)
    }
}
