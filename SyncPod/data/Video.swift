//
//  Video.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/29.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation
import SwiftyJSON

class Video {
    private var _youtubeVideoId: String? = nil
    private var _currentTime: Float?
    
    func set(video: JSON) {
        self._youtubeVideoId = video["youtube_video_id"].string
        self._currentTime = video["current_time"].float
    }
    
    var youtubeVideoId: String? {
        get {
            return _youtubeVideoId
        }
    }

    var currentTime: Float? {
        get {
            return _currentTime
        }
    }
}
