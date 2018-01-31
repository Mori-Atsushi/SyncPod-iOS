//
//  Chat.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/31.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Chat {
    let id: Int
    let chat_type: String
    let message: String
    let created_at: String
    let user: User
    
    init(chat: JSON) {
        id = chat["id"].int!
        chat_type = chat["chat_type"].string!
        message = chat["message"].string!
        created_at = chat["created_ad"].string!
        user = User(user: chat["user"])
    }
}
