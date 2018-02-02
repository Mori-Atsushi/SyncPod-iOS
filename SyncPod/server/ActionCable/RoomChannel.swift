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
    func onReceiveNowPlayingVideo(json: JSON) -> Void
    func onReceiveStartVideo(json: JSON) -> Void
    func onReceivePastChats(json: JSON) -> Void
    func onReceiveChat(json: JSON) -> Void
}

class RoomChannel {
    let host = "ws://59.106.220.89:3000/cable/"
    let client: ActionCableClient
    var roomChannel: Channel?
    var roomChannelDelegate: RoomChannelDelegate

    init(roomKey: String, delegate: RoomChannelDelegate) {
        self.client = ActionCableClient(url: URL(string: "\(self.host)?token=\(CurrentUser.userToken!)")!)
        self.roomChannelDelegate = delegate;

        client.willConnect = { }

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

    func getNowPlayingVideo() {
        self.roomChannel?.action("now_playing_video")
    }
    
    func getChatList() {
        self.roomChannel?.action("past_chats")
    }
    
    func disconnect() {
        client.disconnect()
    }

    private func setupChannel(roomKey: String) {
        let room_identifier = ["room_key": roomKey]
        self.roomChannel = self.client.create("RoomChannel", identifier: room_identifier)

        self.roomChannel?.onSubscribed = {
            self.roomChannelDelegate.onSubscribed()
        }

        self.roomChannel?.onUnsubscribed = {
            print("Unsubscribed")
        }

        self.roomChannel?.onRejected = {
            print("Rejected")
        }

        self.roomChannel?.onReceive = { (data: Any?, error: Error?) in
            let json = JSON(parseJSON: data! as! String)
            switch json["data_type"] {
            case "now_playing_video":
                self.roomChannelDelegate.onReceiveNowPlayingVideo(json: json)
            case "start_video":
                self.roomChannelDelegate.onReceiveStartVideo(json: json)
            case "past_chats":
                self.roomChannelDelegate.onReceivePastChats(json: json)
            case "add_chat":
                self.roomChannelDelegate.onReceiveChat(json: json)
            default:
                print("Received", data!)
            }
        }
    }
}
