//
//  JoinedRoomTableViewCell.swift
//  SyncPod
//
//  Created by 森篤史 on 2018/01/26.
//  Copyright © 2018年 Cyder. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

class JoinedRoomsTabledViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var onlineMemberNum: UILabel!
    @IBOutlet weak var recentVideo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(room: JSON) {
        self.name.text = room["name"].string!
        self.roomDescription.text = room["description"].string!
        self.onlineMemberNum.text = "オンライン: " + room["online_users"].count.description + "人"
        var urlString: String?
        if(room["now_playing_video"]["title"].exists()) {
            self.recentVideo.text = "再生中: " + room["now_playing_video"]["title"].string!
            urlString = room["now_playing_video"]["thumbnail_url"].string
        } else if(room["last_played_video"]["title"].exists()) {
            self.recentVideo.text = "再生終了: " + room["last_played_video"]["title"].string!
            urlString = room["last_played_video"]["thumbnail_url"].string
        }

        if(urlString != nil) {
            Alamofire.request(urlString!).responseImage { response in
                if let image = response.result.value {
                    self.thumbnailImage.image = image
                }
            }
        }
    }
}
