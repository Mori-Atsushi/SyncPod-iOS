//
//  UserTableViewCell.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/02/16.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(user: User) {
        name.text = user.name
    }
}
