//
//  UrlExtention.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/30.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import Foundation

extension URL {
    var fragments: [String: String] {
        var results: [String: String] = [:]
        guard let urlComponents = NSURLComponents(string: self.absoluteString), let items = urlComponents.queryItems else {
            return results
        }

        for item in items {
            results[item.name] = item.value
        }

        return results
    }
}
