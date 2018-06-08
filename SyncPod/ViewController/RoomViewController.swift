//
//  RoomViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/18.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import SwiftyJSON
import YouTubeiOSPlayerHelper

class RoomViewController: UIViewController, RoomChannelDelegate, YTPlayerViewDelegate {

    var roomKey: String = ""
    var room = DataStore.CurrentRoom
    var isBackground = true

    var playerVars = [
        "origin": "https://youtube.com" as AnyObject,
        "playsinline": "1" as AnyObject,
        "controls": "0" as AnyObject,
        "disablekb": "1" as AnyObject,
        "showinfo": "0" as AnyObject,
        "start": "0" as AnyObject,
        "rel": "0" as AnyObject
    ]
    let center = NotificationCenter.default

    @IBOutlet weak var videoPlayer: YTPlayerView!
    @IBOutlet weak var videoPlayerContainer: UIView!
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DataStore.roomChannel = RoomChannel(roomKey: roomKey, delegate: self)
        room.key = roomKey
        videoPlayer.delegate = self
        videoPlayer.isUserInteractionEnabled = false
        videoPlayerContainer.isHidden = true
        
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
        } else {
            isBackground = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startRoom()
        isBackground = false
        if(!videoPlayerContainer.isHidden) {
            self.navigationController?.navigationBar.isHidden = true
        }
        if DataStore.roomChannel == nil {
            onRejected()
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
            message: "入室できませんでした。ルームキーが間違ってるか、ブロックされている可能性があります。",
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
            readyVideo(video: json["data"]["video"], isPlaying: true)
        } else {
            endVideo()
        }
    }

    func onReceiveStartVideo(json: JSON) {
        if(json["data"]["video"] != JSON.null) {
            readyVideo(video: json["data"]["video"], isPlaying: true)
            room.playList.remove(video: json["data"]["video"])
        }
    }
    
    func onReceivePlayList(json: JSON) {
        if(json["data"]["play_list"] != JSON.null) {
            room.playList.set(list: json["data"]["play_list"])
        }
    }
    
    func onReceiveAddVideo(json: JSON) {
        if room.playList.isEmpty && room.nowPlayingVideo.status == .none {
            readyVideo(video: json["data"]["video"], isPlaying: false)
        } else {
            room.playList.add(video: json["data"]["video"])
        }
    }
    
    func onReceivePastChats(json: JSON) {
        room.chatList.set(list: json["data"]["past_chats"])
    }
    
    func onReceiveChat(json: JSON) {
        room.chatList.add(chat: json["data"]["chat"])
    }
    
    func onReceiveError(json: JSON) {
        switch json["data"]["message"] {
        case "force exit":
            DataStore.roomChannel?.disconnect()
            DataStore.roomChannel = nil
            let alart = ErrorAlart(viewController: self,
                                   title: "強制退出",
                                   message: "他のユーザから強制退室を受けました。今後しばらくこのルームには入室できません。",
                                   callback: { self.navigationController?.popViewController(animated: true) })
            alart.show()
        default:
            print(json["data"]["message"])
        }
    }
    
    private func readyVideo(video: JSON, isPlaying: Bool) {
        let lastVideoYoutubeVideoId = room.nowPlayingVideo.video?.youtubeVideoId
        room.nowPlayingVideo.set(video: video)
        if isPlaying {
            room.nowPlayingVideo.play()
        }
        let videoId = room.nowPlayingVideo.video!.youtubeVideoId
        let videoCurrentTime = room.nowPlayingVideo.video!.currentTime
        if(lastVideoYoutubeVideoId == videoId) {
            videoPlayer.seek(toSeconds: videoCurrentTime, allowSeekAhead: true)
            playerViewDidBecomeReady(videoPlayer)
        } else {
            playerVars["start"] = videoCurrentTime as AnyObject
            videoPlayer.load(withVideoId: videoId, playerVars: playerVars)
            videoPlayerContainer.isHidden = false
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    private func endVideo() {
        room.nowPlayingVideo.clear()
        videoPlayer.stopVideo()
        self.videoPlayerContainer.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
    }

    func playerViewDidBecomeReady(_ videoPlayer: YTPlayerView) {
        if(room.nowPlayingVideo.status == .playing && !isBackground) {
            videoPlayer.playVideo()
        } else {
            videoPlayer.pauseVideo()
        }
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        if(state == .ended) {
            if room.playList.isEmpty {
                endVideo()
            } else {
                let nextVideo = room.playList.get(index: 0)
                playerVars["start"] = "0" as AnyObject
                videoPlayer.load(withVideoId: nextVideo.youtubeVideoId, playerVars: playerVars)
                room.nowPlayingVideo.set(video: nextVideo)
                room.playList.remove(index: 0)
            }
        }
    }
}
