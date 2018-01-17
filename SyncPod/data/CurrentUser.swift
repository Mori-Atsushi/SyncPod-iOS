//
//  CurrentUser.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/17.
//  Copyright © 2018年 Cyder. All rights reserved.
//
import Foundation

class CurrentUser {
    static private var _userToken: String?
    static var userToken: String? {
        get {
            if(_userToken == nil) {
                _userToken = UserDefaults.standard.string(forKey: "userToken")
            }
            return _userToken
        }
        set {
            _userToken = newValue
            UserDefaults.standard.set(newValue, forKey: "userToken")
        }
    }
}
