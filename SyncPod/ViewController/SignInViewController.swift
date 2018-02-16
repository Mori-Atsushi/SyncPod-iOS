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
        mailField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        passwordField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
    }

    @IBAction func sendSignIn(_ sender: UIButton) {
        let email = mailField.text!
        let password = passwordField.text!

        if validate(email: email, password: password) {
            sendSignInHttp(email: email, password: password)
        }
    }

    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }

    func onSuccess(data: JSON) {
        CurrentUser.userToken = data["user"]["access_token"].string
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "NavigationController") as UIViewController
        present(viewController, animated: true)
    }

    func onFailure(error: Error) {
        ErrorAlart(viewController: self, title: "ログイン失敗", message: "ログインに失敗しました。メールアドレスとパスワードを確認してください。").show()
    }

    private func validate(email: String, password: String) -> Bool {
        if (email == "" || password == "") {
            ErrorAlart(viewController: self, title: "ログイン失敗", message: "全てのフォームを入力して下さい。").show()
            return false;
        }

        return true;
    }

    private func sendSignInHttp(email: String, password: String) {
        let Http = HttpRequestHelper(delegate: self)
        let data: Parameters = [
            "email": email,
            "password": password
        ]
        Http.post(data: data, endPoint: "login")
    }
}
