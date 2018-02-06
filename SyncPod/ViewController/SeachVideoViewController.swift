//
//  SeachVideoViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/02/07.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class  SeachVideoViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        if !searchBar.text!.isEmpty {
            DataStore.roomChannel?.addVideo(searchBar.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
