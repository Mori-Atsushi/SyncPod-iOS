//
//  HttpRequestsHelper.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/12.
//  Copyright © 2018年 Cyder. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

protocol HttpRequestDelegate {
    func onSuccess(data: JSON) -> Void
    func onFailure(error: Error) -> Void
}

class HttpRequestHelper {
    let host: String = "http://59.106.220.89:3000/api/v1/"

    var delegate: HttpRequestDelegate!
    var token: String?

    init(delegate: HttpRequestDelegate) {
        self.delegate = delegate
    }
    
    func post(data: Parameters? = nil, endPoint: String) {
        communicate(method: .post, data: data, endPoint: endPoint)
    }
    
    func get(data: Parameters? = nil, endPoint: String) {
        communicate(method: .get, data: data, endPoint: endPoint)
    }

    private func communicate(method: HTTPMethod, data: Parameters?, endPoint: String) {
        let urlString = host + endPoint
        let headers: HTTPHeaders = [
            "Authorization": token ?? "",
            "Accept": "application/json"
        ]

        Alamofire.request(urlString, method: method, parameters: data, headers: headers)
            .validate(statusCode: 200...200)
            .responseJSON { response in
                switch response.result {
                case .success:
                    guard let object = response.result.value else {
                        return
                    }
                    let json = JSON(object)
                    self.delegate.onSuccess(data: json)
                case .failure(let error):
                    self.delegate.onFailure(error: error)
                }
        }
    }
}

