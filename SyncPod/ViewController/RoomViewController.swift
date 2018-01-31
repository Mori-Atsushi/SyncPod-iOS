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
    var roomChannel: RoomChannel?
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
        roomChannel = RoomChannel(roomKey: roomKey, delegate: self)
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
        roomChannel?.disconnect()
        videoPlayer.delegate = nil
        center.removeObserver(self)
        room.nowPlayingVideo.clear()
    }
    
    @objc func restartApp(notification: Notification) {
        print("restart")
        roomChannel?.getNowPlayingVideo()
    }

    func onSubscribed() {
        print("Subscribed!")
        roomChannel?.getNowPlayingVideo()
    }

    func onReceiveNowPlayingVideo(json: JSON) {
        if(json["data"]["video"] != JSON.null) {
            let lastVideoYoutubeVideoId = room.nowPlayingVideo.youtubeVideoId
            room.nowPlayingVideo.set(video: json["data"]["video"])
            let videoId = room.nowPlayingVideo.youtubeVideoId!
            let videoCurrentTime = room.nowPlayingVideo.currentTime!
            if(lastVideoYoutubeVideoId == videoId) {
                videoPlayer.seekTo(videoCurrentTime, seekAhead: true)
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
            let videoId = room.nowPlayingVideo.youtubeVideoId!
            readyVideo(videoId: videoId, time: 0)
        }
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
    }

    func playerReady(_ videoPlayer: YouTubePlayerView) {
        videoPlayer.play()
    }
}
