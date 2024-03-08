//
//  TrainingListTableCell.swift
//  Batch
//
//  Created by shashivendra sengar on 20/12/23.
//

import UIKit

class FollowingListTableCell: UITableViewCell {
    
    @IBOutlet weak var unfollowBtn: BatchButton!
    @IBOutlet weak var followingprofileImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    
    var callBackTOUnfollow:((Int)->())?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblName.font = FontSize.mediumSize18
        lblDetails.font = FontSize.regularSize14
    }
    
    @IBAction func unfollowBtnTapped(_ sender: UIButton) {
        callBackTOUnfollow?(sender.tag)
    }
    
}
