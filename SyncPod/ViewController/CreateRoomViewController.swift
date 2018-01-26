//
//  CreateRoomViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/26.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CreateRoomViewController: UIViewController, HttpRequestDelegate {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    var textViewBorder: CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.layer.cornerRadius = DeviceConst.buttonCornerRadius
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
        textViewBorder?.removeFromSuperlayer()
        textViewBorder = descriptionField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
    }
    
    @IBAction func sendCreateRoom(_ sender: UIButton) {
        let name = nameField.text!
        let description = descriptionField.text!
        
        if validate(name: name, description: description) {
            sendCreateRoomHttp(name: name, description: description)
        }
    }
    
    
    func onSuccess(data: JSON) {
        print(data)
    }
    
    func onFailure(error: Error) {
        ErrorAlart(viewController: self, title: "ルーム作成失敗", message: "エラーが発生しました。").show()
    }
    
    private func validate(name: String, description: String) -> Bool {
        if (name == "" || description == "") {
            ErrorAlart(viewController: self, title: "アカウント登録失敗", message: "全てのフォームを入力して下さい。").show()
            return false;
        }
        return true
    }
    
    private func sendCreateRoomHttp(name: String, description: String) {
        let Http = HttpRequestHelper(delegate: self)
        let data: Parameters = [
            "room": [
                "name": name,
                "description": description
            ]
        ]
        Http.post(data: data, endPoint: "rooms")
    }
}
