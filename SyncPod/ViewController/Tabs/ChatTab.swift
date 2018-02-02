//
//  ChatTab.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/27.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ChatTab: UIViewController, IndicatorInfoProvider, ChatListDelegate, UITableViewDataSource, UITableViewDelegate {
    var itemInfo: IndicatorInfo = "チャット"
    let chatList = DataStore.CurrentRoom.chatList
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatList.delegate = self
        TableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let innerOffset:CGFloat = 9.0
        TableView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: TableView.frame.width - innerOffset)
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func updatedChatList() {
        print("chat updated")
        self.TableView.reloadData()
    }
    
    //データを返すメソッド（スクロールなどでページを更新する必要が出るたびに呼び出される）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Chat", for: indexPath as IndexPath) as! ChatTableViewCell
        cell.setCell(chat: chatList.get(index: chatList.count - indexPath.row - 1))
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
        return cell
    }
    
    //データの個数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
}

