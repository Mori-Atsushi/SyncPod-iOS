//
//  RoomInfoTab.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/27.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Alamofire
import SwiftyJSON

class RoomInfoTab: UIViewController, IndicatorInfoProvider, HttpRequestDelegate {
    var itemInfo: IndicatorInfo = "ルーム情報"
    let room = DataStore.CurrentRoom
    
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.layer.cornerRadius = DeviceConst.buttonCornerRadius
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(self.room.key != nil) {
            let http = HttpRequestHelper(delegate: self)
            http.get(data: ["room_key": self.room.key!], endPoint: "rooms")
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func onSuccess(data: JSON) {
        print(data)
        self.roomName.text = data["room"]["name"].string
        self.roomDescription.text = data["room"]["description"].string
    }
    
    func onFailure(error: Error) {
        print(error)
    }
}

