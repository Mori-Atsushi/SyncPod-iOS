//
//  UserReportViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/03/22.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import SwiftyJSON

class  UserReportViewController: UIViewController, UINavigationBarDelegate {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
}
