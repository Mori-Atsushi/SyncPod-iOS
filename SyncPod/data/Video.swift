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
    let id: Int
    let youtubeVideoId: String
    let currentTime: Float
    let title: String
    let channelTitle: String?
    let published: String?
    let viewCount: Int?
    let duration: String
    let thumbnailUrl: String?

    init(video: JSON) {
        id = video["id"].int!
        youtubeVideoId = video["youtube_video_id"].string!
        currentTime = video["current_time"].float!
        title = video["title"].string!
        channelTitle = video["channel_title"].string
        published = video["published"].string
        viewCount = video["view_count"].int
        duration = video["duration"].string!
        thumbnailUrl = video["thumbnail_url"].string
    }
    
    var viewCountString: String? {
        get {
            if(self.viewCount != nil) {
                let formatter = NumberFormatter()
                formatter.numberStyle = NumberFormatter.Style.decimal
                formatter.groupingSeparator = ","
                formatter.groupingSize = 3
                return formatter.string(from: self.viewCount! as NSNumber)
            } else {
                return nil
            }
        }
    }
}
