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
    
    override func viewDidLoad() {
        settings.style.buttonBarItemBackgroundColor = DeviceConst.lightGray
        settings.style.selectedBarBackgroundColor = DeviceConst.greenColor
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .gray
            newCell?.label.textColor = .black
        }
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        //管理されるViewControllerを返す処理
        let firstVC = UIStoryboard(name: "Tabs", bundle: nil).instantiateViewController(withIdentifier: "PlayListTab")
        let secondVC = UIStoryboard(name: "Tabs", bundle: nil).instantiateViewController(withIdentifier: "ChatTab")
        let thirdVC = UIStoryboard(name: "Tabs", bundle: nil).instantiateViewController(withIdentifier: "RoomInfoTab")
        let childViewControllers:[UIViewController] = [firstVC, secondVC, thirdVC]
        return childViewControllers
    }
}
