//
//  VideoThunbListTblCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 14/02/24.
//

import UIKit

class VideoThunbListTblCell: UITableViewCell {
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var videoThunbnailImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
