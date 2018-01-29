//
//  Video.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/29.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol VideoDataDelegate {
    func update()
}

class Video {
    private var _youtubeVideoId: String?
    private var _currentTime: Float?
    private var _title: String?
    private var _channelTitle: String?
    private var _published: String?
    private var _viewCount: Int?
    var delegate: VideoDataDelegate?

    func set(video: JSON) {
        self._youtubeVideoId = video["youtube_video_id"].string
        self._currentTime = video["current_time"].float
        self._title = video["title"].string
        self._channelTitle = video["channel_title"].string
        self._published = video["published"].string
        self._viewCount = video["view_count"].int
        delegate?.update()
    }

    var youtubeVideoId: String? {
        get { return _youtubeVideoId }
    }

    var currentTime: Float? {
        get { return _currentTime }
    }

    var title: String? {
        get { return _title }
    }

    var channelTitle: String? {
        get { return _channelTitle }
    }
    
    var published: String? {
        get { return _published }
    }
    
    var viewCount: Int? {
        get { return _viewCount }
    }

    var viewCountString: String? {
        get {
            if(self._viewCount != nil) {
                let formatter = NumberFormatter()
                formatter.numberStyle = NumberFormatter.Style.decimal
                formatter.groupingSeparator = ","
                formatter.groupingSize = 3
                return formatter.string(from: self._viewCount! as NSNumber)
            } else {
                return nil
            }
        }
    }
}
