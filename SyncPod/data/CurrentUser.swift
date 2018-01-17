//
//  CurrentUser.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/17.
//  Copyright © 2018年 Cyder. All rights reserved.
//

class CurrentUser {
    static private var _userToken: String?
    static var userToken: String? {
        get {
            return _userToken
        }
        set {
            _userToken = newValue
        }
    }
}
