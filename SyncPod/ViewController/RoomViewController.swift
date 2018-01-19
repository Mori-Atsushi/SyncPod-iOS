//
//  RoomViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/18.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import ActionCableClient

class RoomViewController: UIViewController {
    var roomKey: String = ""

    override func viewDidLoad() {
        setupWebSocket()
    }
    
    private func setupWebSocket() {
        let client = ActionCableClient(url: URL(string: "ws://59.106.220.89:3000/cable/?token=\(CurrentUser.userToken!)")!)
        
        client.willConnect = {
            print("Will Connect")
        }
        
        client.onConnected = {
            print("Connected")
        }
        
        client.onDisconnected = {(error: ConnectionError?) in
            print("Disconected with error: \(String(describing: error))")
        }
        
        client.willReconnect = {
            print("Reconnecting")
            return true
        }
        
        let room_identifier = ["room_key" : roomKey]
        let roomChannel = client.create("RoomChannel", identifier: room_identifier)
        roomChannel.onSubscribed = {
            print("Subscribed!")
        }

        roomChannel.onUnsubscribed = {
            print("Unsubscribed")
        }
        
        roomChannel.onRejected = {
            print("Rejected")
        }
        
        client.connect()
    }
}
