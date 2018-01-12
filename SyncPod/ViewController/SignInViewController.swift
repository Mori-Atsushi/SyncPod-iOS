//
//  SignInViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/12.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController, UINavigationBarDelegate {
    @IBOutlet weak var navigationBar: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationBar.delegate = self
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
