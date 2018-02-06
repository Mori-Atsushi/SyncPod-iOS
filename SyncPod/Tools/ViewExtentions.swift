//
//  ViewExtentions.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/16.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

extension UITextField {
    func addBorderBottom(height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
    }
}

extension UITextView {
    func addBorderBottom(height: CGFloat, color: UIColor) -> CALayer {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color.cgColor
        self.layer.addSublayer(border)
        self.layer.masksToBounds = false
        return border
    }
}

extension Array where Element:UIViewController {
    func indexOfArray(_ searchObject: UIViewController) -> Int? {
        for (index, value) in self.enumerated() {
            if value == searchObject {
                return index
            }
        }
        return nil
    }
}
