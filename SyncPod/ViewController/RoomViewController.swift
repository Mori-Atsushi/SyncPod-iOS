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
        videoPlayer.delegate = nil
        center.removeObserver(self)
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
        print(json)
        if let videoId = json["data"]["video"]["youtube_video_id"].string {
            let videoCurrentTime = json["data"]["video"]["current_time"].float!
            readyVideo(videoId: videoId, time: videoCurrentTime)
        }
    }

    func onReceiveStartVideo(json: JSON) {
        if let videoId = json["data"]["video"]["youtube_video_id"].string {
            readyVideo(videoId: videoId, time: 0)
        }
    }
    
    private func readyVideo(videoId: String, time: Float) {
        videoPlayer.playerVars["start"] = time as AnyObject
        videoPlayer.loadVideoID(videoId)
        videoPlayer.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }

    func playerReady(_ videoPlayer: YouTubePlayerView) {
        videoPlayer.play()
    }
}
