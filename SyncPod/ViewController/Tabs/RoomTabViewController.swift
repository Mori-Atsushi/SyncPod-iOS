//
//  RoomTabViewController.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/27.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class RoomTabViewController: ButtonBarPagerTabStripViewController {
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        //管理されるViewControllerを返す処理
        let firstVC = UIStoryboard(name: "Tabs", bundle: nil).instantiateViewController(withIdentifier: "PlayListTab")
        let secondVC = UIStoryboard(name: "Tabs", bundle: nil).instantiateViewController(withIdentifier: "ChatTab")
        let thirdVC = UIStoryboard(name: "Tabs", bundle: nil).instantiateViewController(withIdentifier: "RoomInfoTab")
        let childViewControllers:[UIViewController] = [firstVC, secondVC, thirdVC]
        return childViewControllers
    }
}
