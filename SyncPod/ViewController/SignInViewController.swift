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
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationBar.delegate = self

        mailField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        passwordField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        submitButton.layer.cornerRadius = DeviceConst.buttonCornerRadius
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
