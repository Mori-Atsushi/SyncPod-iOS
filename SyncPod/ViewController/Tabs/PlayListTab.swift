//
//  PlayListTab.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/27.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PlayListTab: UIViewController, IndicatorInfoProvider, VideoDataDelegate {
    var itemInfo: IndicatorInfo = "プレイリスト"
    let nowPlyaingVideo = DataStore.CurrentRoom.nowPlayingVideo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nowPlyaingVideo.delegate = self
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func update() {
        print("updated")
    }
}
