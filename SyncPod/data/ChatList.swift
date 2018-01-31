//
//  ChatList.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/31.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ChatListDelegate {
    func update()
}

class ChatList {
    private var list: [Chat] = []
    var delegate: ChatListDelegate?
    
    func set(list: JSON) {
        print(list)
        self.list = list.arrayValue.map { Chat(chat: $0) }
        delegate?.update()
    }
}
