//
//  PlayList.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/29.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol PlayListDelegate {
    func updatedPlayList()
}

class PlayList {
    private var list: [Video] = []
    var delegate: PlayListDelegate?
    
    func set(list: JSON) {
        self.list = list.arrayValue.map { Video(video: $0) }
        delegate?.updatedPlayList()
    }
    
    func add(video: JSON) {
        self.list.append(Video(video: video))
        delegate?.updatedPlayList()
    }
    
    func remove(index: Int) {
        self.list.remove(at: index)
        delegate?.updatedPlayList()
    }
    
    func remove(video: JSON) {
        let v = Video(video: video)
        if !list.isEmpty && list[0].id == v.id {
            remove(index: 0)
        }
    }
    
    func get(index: Int) -> Video {
        return list[index]
    }
    
    var isEmpty: Bool {
        get {
            return list.isEmpty
        }
    }
    
    var count: Int {
        get {
            return list.count
        }
    }
}
