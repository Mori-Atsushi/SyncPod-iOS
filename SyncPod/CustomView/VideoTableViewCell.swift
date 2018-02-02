//
//  VideoTableViewCell.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/02/02.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var published: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(video: Video) {
        title.text = video.title
        channelTitle.text = video.channelTitle
        published.text = "公開: " + (video.published ?? "")
        viewCount.text = "再生回数: " + (video.viewCountString ?? "0") + " 回"
        duration.text = video.duration
        
        if(video.thumbnailUrl != nil) {
            Alamofire.request(video.thumbnailUrl!).responseImage { response in
                if let image = response.result.value {
                    self.thumbnailImage.image = image
                }
            }
        }
    }
}
