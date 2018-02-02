//
//  Room.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/29.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation
import SwiftyJSON

class Room {
    var nowPlayingVideo = NowPlayingVideo()
    var playList = PlayList()
    var chatList = ChatList()
    var key: String?
}
