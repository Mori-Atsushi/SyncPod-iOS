//
//  SeachVideoViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/02/07.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import SwiftyJSON

class  SeachVideoViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, HttpRequestDelegate {
    
    var http: HttpRequestHelper?
    var result = [Video]()
    var nextToken: String?
    var keyword: String?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        http = HttpRequestHelper(delegate: self)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if !searchBar.text!.isEmpty {
            self.result.removeAll()
            self.nextToken = nil
            self.tableView.reloadData()
            self.keyword = searchBar.text!
            let data = ["keyword": self.keyword!]
            http?.get(data: data, endPoint: "youtube/search")
        }
    }
    
    func onSuccess(data: JSON) {
        print(data)
        result.append(contentsOf: data["items"].arrayValue.map { Video(video: $0 ) })
        nextToken = data["next_page_token"].string
        self.tableView.reloadData()
    }
    
    func onFailure(error: Error) {
        print(error)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetY = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.height
        let distanceToBottom = maximumOffset - currentOffsetY
        if distanceToBottom < 500 && nextToken != nil {
            let data = ["keyword": self.keyword!, "page_token": nextToken!]
            http?.get(data: data, endPoint: "youtube/search")
            nextToken = nil
        }
    }
    
    //データを返すメソッド（スクロールなどでページを更新する必要が出るたびに呼び出される）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Video", for: indexPath as IndexPath) as! VideoTableViewCell
        cell.setCell(video: result[indexPath.row])
        return cell
    }
    
    //データの個数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    //タッチされた時の挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataStore.roomChannel?.addVideo(result[indexPath.row].youtubeVideoId)
        self.dismiss(animated: true, completion: nil)
    }
}
