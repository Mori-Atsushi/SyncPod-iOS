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
    func onRejected() -> Void
    func onReceiveNowPlayingVideo(json: JSON) -> Void
    func onReceiveStartVideo(json: JSON) -> Void
    func onReceivePlayList(json: JSON) -> Void
    func onReceiveAddVideo(json: JSON) -> Void
    func onReceivePastChats(json: JSON) -> Void
    func onReceiveChat(json: JSON) -> Void
    func onReceiveError(json: JSON) -> Void
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
    
    func getPlayList() {
        self.roomChannel?.action("play_list")
    }
    
    func getChatList() {
        self.roomChannel?.action("past_chats")
    }
    func sendChat(_ message: String) {
        self.roomChannel?.action("message", with: ["message": message])
    }
    
    func addVideo(_ videoId: String) {
        self.roomChannel?.action("add_video", with: ["youtube_video_id": videoId])
    }
    
    func exitForce(_ user: User) {
        self.roomChannel?.action("exit_force", with: ["user_id": user.id])
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
            self.roomChannelDelegate.onRejected()
        }

        self.roomChannel?.onReceive = { (data: Any?, error: Error?) in
            let json = JSON(parseJSON: data! as! String)
            switch json["data_type"] {
            case "now_playing_video":
                self.roomChannelDelegate.onReceiveNowPlayingVideo(json: json)
            case "start_video":
                self.roomChannelDelegate.onReceiveStartVideo(json: json)
            case "add_video":
                self.roomChannelDelegate.onReceiveAddVideo(json: json)
            case "play_list":
                self.roomChannelDelegate.onReceivePlayList(json: json)
            case "past_chats":
                self.roomChannelDelegate.onReceivePastChats(json: json)
            case "add_chat":
                self.roomChannelDelegate.onReceiveChat(json: json)
            case "error":
                self.roomChannelDelegate.onReceiveError(json: json)
            default:
                print("Received", data!)
            }
        }
    }
}
