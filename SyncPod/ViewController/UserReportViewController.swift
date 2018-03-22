//
//  UserReportViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/03/22.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class  UserReportViewController: UIViewController, UINavigationBarDelegate, HttpRequestDelegate {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendUserReport(_ sender: UIButton) {
        let message = messageField.text!
        
        if validate(message: message) {
            sendUserReportHttp(message: message)
        }
    }
    
    var textViewBorder: CALayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegate = self
        submitButton.layer.cornerRadius = DeviceConst.buttonCornerRadius
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textViewBorder?.removeFromSuperlayer()
        textViewBorder = messageField.addBorderBottom(height: DeviceConst.textFieldBorderHeight, color: UIColor.lightGray)
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func onSuccess(data: JSON) {
        print(data)
        self.dismiss(animated: true, completion: nil)
    }
    
    func onFailure(error: Error) {
        ErrorAlart(viewController: self, title: "送信失敗", message: "エラーが発生しました。").show()
    }
    
    private func validate(message: String) -> Bool {
        if (message == "") {
            ErrorAlart(viewController: self, title: "送信失敗", message: "全てのフォームを入力して下さい。").show()
            return false;
        }
        return true
    }
    
    private func sendUserReportHttp(message: String) {
        let Http = HttpRequestHelper(delegate: self)
        let data: Parameters = [
            "message": message
        ]
        Http.post(data: data, endPoint: "user_report")
    }
}
