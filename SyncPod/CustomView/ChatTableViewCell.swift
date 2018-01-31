//
//  ChatrTableViewCell.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/31.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var message: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(chat: Chat) {
        name.text = chat.user?.name ?? "お知らせ"
        time.text = chat.created_at
        message.text = chat.message
    }
}
