//
//  TopViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/18.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {
    @IBOutlet weak var JoinRoomPanel: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //ナビゲーションアイテムのタイトルに画像を設定する。
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "title"))
        
        //タッチ制御
        let joinRoomTap = UITapGestureRecognizer(target: self, action: #selector(TopViewController.joinRoom(_:)))
        self.JoinRoomPanel.addGestureRecognizer(joinRoomTap)
    }
    
    @objc func joinRoom(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "ルームに参加する", message: "ルームキーを入力して下さい。", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.default)
        let defaultAction = UIAlertAction(title: "送信", style: UIAlertActionStyle.default, handler: {
            (action:UIAlertAction!) -> Void in
            self.performSegue(withIdentifier: "JoinRoomSegue", sender: nil)
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        alert.addTextField(configurationHandler: {(text:UITextField!) -> Void in
            text.placeholder = "ルームキー"
        })
        present(alert, animated: true)
    }
}
