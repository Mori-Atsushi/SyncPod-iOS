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

class CreateRoomViewController: UIViewController {
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
}
