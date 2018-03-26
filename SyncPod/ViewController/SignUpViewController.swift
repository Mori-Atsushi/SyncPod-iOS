//
//  SignupViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/16.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController, UINavigationBarDelegate, HttpRequestDelegate {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var termsSwitch: UISwitch!
    
    @IBAction func openTerms(_ sender: UIButton) {
        let url = URL(string: "http://app.sync-pod.com/terms")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationBar.delegate = self
        
        submitButton.layer.cornerRadius = DeviceConst.buttonCornerRadius
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        mailField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        passwordField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        passwordConfirmField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
    }

    @IBAction func sendSignUp(_ sender: UIButton) {
        let name = nameField.text!
        let email = mailField.text!
        let password = passwordField.text!
        let passwordConfirm = passwordConfirmField.text!

        if validate(name: name, email: email, password: password, passwordConfirm: passwordConfirm) {
            sendSignUpHttp(name: name, email: email, password: password)
        }
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    func onSuccess(data: JSON) {
        CurrentUser.userToken = data["user"]["access_token"].string
        CurrentUser.id = data["user"]["id"].int
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as UIViewController
        present(viewController, animated: true)
    }

    func onFailure(error: Error) {
        ErrorAlart(viewController: self, title: "アカウント登録失敗", message: "アカウント登録に失敗しました。メールアドレスが既に使われている可能性があります。").show()
    }

    private func validate(name: String, email: String, password: String, passwordConfirm: String) -> Bool {
        if (email == "" || name == "" || password == "" || passwordConfirm == "") {
            ErrorAlart(viewController: self, title: "アカウント登録失敗", message: "全てのフォームを入力して下さい。").show()
            return false;
        }
        if password != passwordConfirm {
            ErrorAlart(viewController: self, title: "アカウント登録失敗", message: "2つのパスワードが異なります。").show()
            return false;
        }
        if password.count < 6 {
            ErrorAlart(viewController: self, title: "アカウント登録失敗", message: "パスワードが短すぎます。").show()
            return false;
        }

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        if !emailTest.evaluate(with: email) {
            ErrorAlart(viewController: self, title: "アカウント登録失敗", message: "メールが正しくありません。").show()
            return false;
        }

        if(!termsSwitch.isOn) {
            ErrorAlart(viewController: self, title: "ログイン失敗", message: "利用規約に同意して下さい。").show()
            return false;
        }

        return true;
    }

    private func sendSignUpHttp(name: String, email: String, password: String) {
        let Http = HttpRequestHelper(delegate: self)
        let data: Parameters = [
            "user": [
                "name": name,
                "email": email,
                "password": password
            ]
        ]
        Http.post(data: data, endPoint: "users")
    }
}

