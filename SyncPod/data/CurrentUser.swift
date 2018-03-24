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
    static private var _id: Int?
    static var userToken: String? {
        get {
            _userToken = _userToken ?? UserDefaults.standard.string(forKey: "userToken")
            return _userToken
        }
        set {
            _userToken = newValue
            UserDefaults.standard.set(newValue, forKey: "userToken")
        }
    }

    static var id: Int? {
        get {
            _id = _id ?? UserDefaults.standard.integer(forKey: "userId")
            return _id
        }
        set {
            _id = newValue
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
    }
}
