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

enum VideoStatus {
    case none
    case ready
    case playing
}

class NowPlayingVideo {
    var delegate: VideoDataDelegate?
    var video: Video?
    private var _status: VideoStatus = .none
    
    var status: VideoStatus {
        get {
            return _status
        }
    }
    
    func set(video: JSON) {
        self.video = Video(video: video)
        delegate?.updatedVideoData()
        self._status = .ready
    }
    
    func play() {
        self._status = .playing
    }
    
    func clear() {
        self.video = nil
        self._status = .none
        delegate?.updatedVideoData()
    }
}
