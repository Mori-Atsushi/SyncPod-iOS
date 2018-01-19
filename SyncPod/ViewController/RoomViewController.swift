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
    var roomChannel: RoomChannel?;
    
    @IBOutlet weak var videoPlayer: YouTubePlayerView!

    override func viewDidLoad() {
        roomChannel = RoomChannel(roomKey: roomKey, delegate: self)
        videoPlayer.delegate = self
        videoPlayer.playerVars = [
            "playsinline": "1" as AnyObject,
            "controls": "0" as AnyObject,
            "disablekb": "1" as AnyObject,
            "showinfo": "0" as AnyObject,
            "rel": "0" as AnyObject,
            "iv_load_policy": "3" as AnyObject
        ]
    }
    
    func onSubscribed() {
        print("Subscribed!")
        roomChannel?.getNowPlayingVideo()
    }
    
    func onReceiveNowPlayingVideo(json: JSON) {
        if let videoId = json["data"]["video"]["youtube_video_id"].string {
            videoPlayer.loadVideoID(videoId)
        }
    }
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        print("startPlay")
        videoPlayer.play()
    }
}
