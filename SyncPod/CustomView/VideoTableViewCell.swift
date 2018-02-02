//
//  VideoTableViewCell.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/02/02.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(video: Video) {
        title.text = video.title
    }
}
