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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
}
