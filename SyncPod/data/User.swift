//
//  User.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/31.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    let id: Int
    let name: String
    
    init(user: JSON) {
        id = user["id"].int!
        name = user["name"].string!
    }
}
