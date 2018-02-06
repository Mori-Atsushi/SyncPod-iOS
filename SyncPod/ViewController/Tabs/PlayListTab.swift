//
//  PlayListTab.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/27.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class PlayListTab: UIViewController, IndicatorInfoProvider, VideoDataDelegate, PlayListDelegate, UITableViewDataSource, UITableViewDelegate {
    var itemInfo: IndicatorInfo = "プレイリスト"
    let nowPlayingVideo = DataStore.CurrentRoom.nowPlayingVideo
    let playList = DataStore.CurrentRoom.playList

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var nowPlayingVideoTitle: UILabel!
    @IBOutlet weak var nowPlayingVideoChannel: UILabel!
    @IBOutlet weak var nowPlayingVideoInfo: UILabel!
    @IBOutlet weak var nowPlaingVideoView: UIView!
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        nowPlayingVideo.delegate = self
        playList.delegate = self
        addButton.layer.cornerRadius = addButton.frame.width / 2
        addButton.layer.masksToBounds = false
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOpacity = 0.3
        addButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addButton.layer.shadowRadius = 5
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let headerView = TableView.tableHeaderView else {
            return
        }
        
        let size = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            TableView.tableHeaderView = headerView
        }
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }

    func updatedVideoData() {
        if nowPlayingVideo.video != nil {
            nowPlaingVideoView.isHidden = false
            nowPlayingVideoTitle.text = nowPlayingVideo.video?.title
            nowPlayingVideoChannel.text = nowPlayingVideo.video?.channelTitle
            let published = nowPlayingVideo.video?.published ?? ""
            let viewCount = nowPlayingVideo.video?.viewCountString ?? "0"
            nowPlayingVideoInfo.text = "公開: " + published + " 視聴回数: " + viewCount + " 回"
        } else {
            nowPlaingVideoView.isHidden = true
        }
    }

    func updatedPlayList() {
        if(playList.count == 0) {
            self.emptyMessage.isHidden = false
        } else {
            self.emptyMessage.isHidden = true
        }
        self.TableView.reloadData()
    }

    //データを返すメソッド（スクロールなどでページを更新する必要が出るたびに呼び出される）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Video", for: indexPath as IndexPath) as! VideoTableViewCell
        cell.setCell(video: playList.get(index: indexPath.row))
        return cell
    }

    //データの個数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playList.count
    }
}
