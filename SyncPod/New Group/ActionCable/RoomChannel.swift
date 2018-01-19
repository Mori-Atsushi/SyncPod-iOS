//
//  RoomChannel.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/20.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import ActionCableClient
import SwiftyJSON

protocol RoomChannelDelegate {
    func onSubscribed() -> Void
}

class RoomChannel {
    let host = "ws://59.106.220.89:3000/cable/"
    let client: ActionCableClient
    var roomChannelDelegate: RoomChannelDelegate
    
    init(roomKey: String, delegate: RoomChannelDelegate) {
        self.client = ActionCableClient(url: URL(string: "\(self.host)?token=\(CurrentUser.userToken!)")!)
        self.roomChannelDelegate = delegate;
        
        client.willConnect = {}
        
        client.onConnected = {
            self.setupChannel(roomKey: roomKey)
        }
        
        client.onDisconnected = { (error: ConnectionError?) in
            print("Disconected with error: \(String(describing: error))")
        }
        
        client.willReconnect = {
            return true
        }
        
        client.connect()
    }
    
    private func setupChannel(roomKey: String) {
        let room_identifier = ["room_key": roomKey]
        let roomChannel = self.client.create("RoomChannel", identifier: room_identifier)
        
        roomChannel.onSubscribed = {
            self.roomChannelDelegate.onSubscribed()
        }
        
        roomChannel.onUnsubscribed = {
            print("Unsubscribed")
        }
        
        roomChannel.onRejected = {
            print("Rejected")
        }
    }
}
