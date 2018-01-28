//
//  ChatTab.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/27.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ChatTab: UIViewController, IndicatorInfoProvider {
    var itemInfo: IndicatorInfo = "チャット"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

