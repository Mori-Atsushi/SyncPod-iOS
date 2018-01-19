//
//  RoomViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/18.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import SwiftyJSON

class RoomViewController: UIViewController, RoomChannelDelegate {
    
    var roomKey: String = ""
    var roomChannel: RoomChannel?;

    override func viewDidLoad() {
        roomChannel = RoomChannel(roomKey: roomKey, delegate: self)
    }
    
    func onSubscribed() {
        print("Subscribed!")
        roomChannel?.getNowPlayingVideo()
    }
    
    func onReceiveNowPlayingVideo(json: JSON) {
        print("now_playing_video", json)
    }
}
