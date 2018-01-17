//
//  SignInViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/12.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignInViewController: UIViewController, UINavigationBarDelegate, HttpRequestDelegate {
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

    @IBAction func sendSignIn(_ sender: UIButton) {
        let Http = HttpRequestHelper(delegate: self)
        let data: Parameters = [
            "email": mailField.text!,
            "password": passwordField.text!
        ]
        Http.post(data: data, endPoint: "login")
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    func onSuccess(data: JSON) {
        CurrentUser.userToken = data["user"]["access_token"].string
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TopView") as UIViewController
        present(viewController, animated: true)
    }

    func onFailure(error: Error) {
        let alert = UIAlertController(title: "ログイン失敗", message: "ログインに失敗しました。メールアドレスとパスワードを確認してください。", preferredStyle: UIAlertControllerStyle.alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alert.addAction(defaultAction)
        present(alert, animated: true)
    }
}
