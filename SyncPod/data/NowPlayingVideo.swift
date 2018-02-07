//
//  NowPlayingVideo.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/02/02.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol VideoDataDelegate {
    func updatedVideoData()
}

class NowPlayingVideo {
    var delegate: VideoDataDelegate?
    var video: SyncPodVideo?
    
    func set(video: JSON) {
        self.video = SyncPodVideo(video: video)
        delegate?.updatedVideoData()
    }
    
    func clear() {
        self.video = nil
        delegate?.updatedVideoData()
    }
}
