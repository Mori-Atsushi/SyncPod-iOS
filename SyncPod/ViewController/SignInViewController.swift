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
    
    var isShowKeyboard = false
    var keyboardFrame: CGRect?
    let center = NotificationCenter.default
    
    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
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
        mailField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        passwordField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        
        checkViewSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        center.addObserver(
            self,
            selector: #selector(SignInViewController.showKeyboard(notification:)),
            name: .UIKeyboardWillShow,
            object: nil)
        center.addObserver(
            self,
            selector: #selector(SignInViewController.hideKeyboard(notification:)),
            name: .UIKeyboardWillHide,
            object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isShowKeyboard = false
        center.removeObserver(self)
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
        CurrentUser.id = data["user"]["id"].int
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
        if(!termsSwitch.isOn) {
            ErrorAlart(viewController: self, title: "ログイン失敗", message: "利用規約に同意して下さい。").show()
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
    
    @objc func showKeyboard(notification: Notification) {
        isShowKeyboard = true
        let info = notification.userInfo!
        self.keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        checkViewSize()
    }
    
    @objc func hideKeyboard(notification: Notification) {
        isShowKeyboard = false
        checkViewSize()
    }
    
    private func checkViewSize() {
        let width = MainView.superview!.frame.width
        let defaultHeight = MainView.superview!.frame.height
        let showedKeyboardHeight = defaultHeight - (keyboardFrame?.height ?? 0)
        let height = isShowKeyboard ? showedKeyboardHeight : defaultHeight
        
        MainView.frame = CGRect(x: MainView.frame.origin.x,
                                y: MainView.frame.origin.y,
                                width: width,
                                height: height)
    }
}
