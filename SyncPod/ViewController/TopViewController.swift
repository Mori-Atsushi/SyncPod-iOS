//
//  TopViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/18.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        //ナビゲーションアイテムのタイトルに画像を設定する。
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "title"))
    }
}
