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
    let date: Date
    var user: User?
    
    init(chat: JSON) {
        id = chat["id"].int!
        chat_type = chat["chat_type"].string!
        message = chat["message"].string!

        let f = DateFormatter()
        f.dateFormat = "yyyy/MM/dd HH:mm:ss"
        f.timeZone = TimeZone(secondsFromGMT: 0)
        date = f.date(from: chat["created_at"].string!)!

        if chat_type == "user" {
            user = User(user: chat["user"])
        }
    }
    
    var formatedTime:String {
        get {
            let f = DateFormatter()
            let calendar = Calendar(identifier: .gregorian)
            if calendar.isDateInToday(date) {
                f.timeStyle = .short
                f.dateStyle = .none
            } else {
                f.timeStyle = .short
                f.dateStyle = .short
            }
            return f.string(from: date)
        }
    }
}
