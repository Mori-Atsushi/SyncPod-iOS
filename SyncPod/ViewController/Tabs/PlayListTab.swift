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
    let nowPlayingVideo = DataStore.CurrentRoom.nowPlayingVideo
    
    @IBOutlet weak var nowPlayingVideoTitle: UILabel!
    @IBOutlet weak var nowPlayingVideoChannel: UILabel!
    @IBOutlet weak var nowPlayingVideoInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nowPlayingVideo.delegate = self
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func update() {
        nowPlayingVideoTitle.text = nowPlayingVideo.title
        nowPlayingVideoChannel.text = nowPlayingVideo.channelTitle
        let published = nowPlayingVideo.published ?? ""
        let viewCount = nowPlayingVideo.viewCountString ?? "0"
        nowPlayingVideoInfo.text = "公開: " + published + " 視聴回数: " + viewCount + " 回"
    }
}
