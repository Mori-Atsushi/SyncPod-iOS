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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationBar.delegate = self
        
        nameField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        mailField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        passwordField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        passwordConfirmField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        submitButton.layer.cornerRadius = DeviceConst.buttonCornerRadius
    }
    
    @IBAction func sendSignUp(_ sender: UIButton) {
        let Http = HttpRequestHelper(delegate: self)
        let data: Parameters = [
            "user": [
                "name": nameField.text!,
                "email": mailField.text!,
                "password": passwordField.text!
            ]
        ]
        Http.post(data: data, endPoint: "users")
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
        ErrorAlart(viewController: self, title: "アカウント登録失敗", message: "アカウント登録に失敗しました。メールアドレスが既に使われている可能性があります。").show()
    }
}

