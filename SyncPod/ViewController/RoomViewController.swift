//
//  RoomViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/18.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import SwiftyJSON
import YouTubePlayer

class RoomViewController: UIViewController, RoomChannelDelegate, YouTubePlayerDelegate {

    var roomKey: String = ""
    var room = DataStore.CurrentRoom

    let playerVars = [
        "playsinline": "1" as AnyObject,
        "controls": "0" as AnyObject,
        "disablekb": "1" as AnyObject,
        "showinfo": "0" as AnyObject,
        "start": "0" as AnyObject,
        "rel": "0" as AnyObject
    ]
    let center = NotificationCenter.default

    @IBOutlet weak var videoPlayer: YouTubePlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        DataStore.roomChannel = RoomChannel(roomKey: roomKey, delegate: self)
        room.key = roomKey
        videoPlayer.delegate = self
        videoPlayer.playerVars = playerVars
        videoPlayer.isUserInteractionEnabled = false
        videoPlayer.isHidden = true
        
        center.addObserver(
            self,
            selector: #selector(RoomViewController.restartApp(notification:)),
            name: .UIApplicationDidBecomeActive,
            object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let viewControllers = self.navigationController?.viewControllers
        if viewControllers?.indexOfArray(self) == nil {
            DataStore.roomChannel?.disconnect()
            DataStore.roomChannel = nil
            videoPlayer.delegate = nil
            center.removeObserver(self)
            room.nowPlayingVideo.clear()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startRoom()
        if(!videoPlayer.isHidden) {
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    @objc func restartApp(notification: Notification) {
        print("restart")
        startRoom()
    }

    func onSubscribed() {
        print("Subscribed!")
        startRoom()
    }
    
    func onRejected() {
        let alart = ErrorAlart(viewController: self,
            title: "入室エラー",
            message: "入室できませんでした。ルームキーが間違ってる可能性があります。",
            callback: { self.navigationController?.popViewController(animated: true) })
        alart.show()
    }
    
    func startRoom() {
        DataStore.roomChannel?.getNowPlayingVideo()
        DataStore.roomChannel?.getChatList()
        DataStore.roomChannel?.getPlayList()
    }

    func onReceiveNowPlayingVideo(json: JSON) {
        if(json["data"]["video"] != JSON.null) {
            let lastVideoYoutubeVideoId = room.nowPlayingVideo.video?.youtubeVideoId
            room.nowPlayingVideo.set(video: json["data"]["video"])
            let videoId = room.nowPlayingVideo.video!.youtubeVideoId
            let videoCurrentTime = room.nowPlayingVideo.video!.currentTime
            if(lastVideoYoutubeVideoId == videoId) {
                videoPlayer.seekTo(videoCurrentTime, seekAhead: true)
                videoPlayer.play()
            } else {
                readyVideo(videoId: videoId, time: videoCurrentTime)
            }
        } else {
            endVideo()
        }
    }

    func onReceiveStartVideo(json: JSON) {
        if(json["data"]["video"] != JSON.null) {
            room.nowPlayingVideo.set(video: json["data"]["video"])
            let videoId = room.nowPlayingVideo.video!.youtubeVideoId
            readyVideo(videoId: videoId, time: 0)
            room.playList.remove(video: json["data"]["video"])
        }
    }
    
    func onReceivePlayList(json: JSON) {
        if(json["data"]["play_list"] != JSON.null) {
            room.playList.set(list: json["data"]["play_list"])
        }
    }
    
    func onReceiveAddVideo(json: JSON) {
        room.playList.add(video: json["data"]["video"])
    }
    
    func onReceivePastChats(json: JSON) {
        room.chatList.set(list: json["data"]["past_chats"])
    }
    
    func onReceiveChat(json: JSON) {
        room.chatList.add(chat: json["data"]["chat"])
    }
    
    private func readyVideo(videoId: String, time: Float) {
        videoPlayer.playerVars["start"] = time as AnyObject
        videoPlayer.loadVideoID(videoId)
        videoPlayer.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func endVideo() {
        room.nowPlayingVideo.clear()
        self.videoPlayer.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }

    func playerReady(_ videoPlayer: YouTubePlayerView) {
        videoPlayer.play()
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        if(playerState == .Ended) {
            endVideo()
        }
    }
}
