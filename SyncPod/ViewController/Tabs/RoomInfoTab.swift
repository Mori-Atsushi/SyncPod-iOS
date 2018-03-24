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

class RoomInfoTab: UIViewController, IndicatorInfoProvider, HttpRequestDelegate, UITableViewDataSource, UITableViewDelegate {
    var itemInfo: IndicatorInfo = "ルーム情報"
    let room = DataStore.CurrentRoom
    var onlineUsers: [User]?
    var shareText = ""
    var shareUrl = ""
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var onlineTitle: UILabel!
    
    @IBAction func share(_ sender: UIButton) {
        if let shareWebsite = URL(string: shareUrl) {
            let activityItems = [shareText, shareWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.layer.cornerRadius = DeviceConst.buttonCornerRadius
        
        self.TableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(RoomInfoTab.refresh(sender:)), for: .valueChanged)
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        if(self.room.key != nil) {
            let http = HttpRequestHelper(delegate: self)
            http.get(data: ["room_key": self.room.key!], endPoint: "rooms")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.refresh(sender: refreshControl)
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
    
    func onSuccess(data: JSON) {
        self.roomName.text = data["room"]["name"].string
        self.roomDescription.text = data["room"]["description"].string
        self.shareText = "SyncPodで一緒に動画を見ませんか？\n\nルーム名: \(data["room"]["name"].string!)\nルームキー: \(data["room"]["key"].string!)\n\nこちらのURLからも入室できます。"
        self.shareUrl = "http://app.sync-pod.com/room?room_key=\(data["room"]["key"].string!)"
        self.onlineTitle.text = "オンライン（\(data["room"]["online_users"].count)人）"
        self.onlineUsers = data["room"]["online_users"].arrayValue.map { User(user: $0) }
        self.TableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func onFailure(error: Error) {
        print(error)
        refreshControl.endRefreshing()
    }
    
    //データを返すメソッド（スクロールなどでページを更新する必要が出るたびに呼び出される）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "User", for: indexPath as IndexPath) as! UserTableViewCell
        cell.setCell(user: onlineUsers![indexPath.row])
        return cell
    }
    
    //データの個数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onlineUsers != nil ? onlineUsers!.count : 0
    }
    
    //タッチされた時の挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(onlineUsers![indexPath.row])
        let exitForceActionTitle = onlineUsers![indexPath.row].name + "さんを退出させる"
        let alert: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle:  UIAlertControllerStyle.actionSheet)
        let exitForceAction: UIAlertAction = UIAlertAction(title: exitForceActionTitle, style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) -> Void in
            self.exitForce(target: self.onlineUsers![indexPath.row])
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel)

        alert.addAction(cancelAction)
        alert.addAction(exitForceAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func exitForce(target: User) {
        let title = target.name + "さんを退出させる"
        let message = target.name + "さんは24時間このルームに入室できなくなります。本当によろしいですか？"
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle:  UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "退出させる", style: UIAlertActionStyle.destructive, handler:{
            (action: UIAlertAction!) -> Void in
            DataStore.roomChannel?.exitForce(target)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}

