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
    
    var result = [Video]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if !searchBar.text!.isEmpty {
            let http = HttpRequestHelper(delegate: self)
            let data = ["keyword": searchBar.text!]
            http.get(data: data, endPoint: "youtube/search")

//            DataStore.roomChannel?.addVideo(searchBar.text!)
//            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func onSuccess(data: JSON) {
        print(data)
        result = data["items"].arrayValue.map { Video(video: $0 ) }
        self.tableView.reloadData()
    }
    
    func onFailure(error: Error) {
        print(error)
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
}
