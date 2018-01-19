//
//  RoomViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/18.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import ActionCableClient

class RoomViewController: UIViewController, RoomChannelDelegate {
    
    var roomKey: String = ""

    override func viewDidLoad() {
        var roomChannel = RoomChannel(roomKey: roomKey, delegate: self)
    }
    
    func onSubscribed() {
        print("Subscribed!")
    }
}
