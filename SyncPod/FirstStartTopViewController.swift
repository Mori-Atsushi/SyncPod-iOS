//
//  FirstStartTopViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/11.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class FirstStartViewController: UIViewController {
    @IBAction func goSignInView(_ sender:UIButton) {
        let next = storyboard!.instantiateViewController(withIdentifier: "SignInView")
        self.present(next,animated: true, completion: nil)
    }
    
    @IBAction func goSinupView(_ sender:UIButton) {
        let next = storyboard!.instantiateViewController(withIdentifier: "SignUpView")
        self.present(next,animated: true, completion: nil)
    }
}
