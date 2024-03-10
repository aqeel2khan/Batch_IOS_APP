//
//  BWOPackageTblCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import UIKit

class BWOPackageTblCell: UITableViewCell {
    
    @IBOutlet weak var cellBtn: UIButton!
    @IBOutlet weak var courseLevelTypeLbl: BatchButtonMedium12White!
    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblTitle: BatchMedium18White!
    @IBOutlet weak var woDayCountLbl: BatchMedium18White!
    @IBOutlet weak var coachProfileImg: UIImageView!
    @IBOutlet weak var coachNameLbl: BatchLabelMedium14White!
    @IBOutlet weak var workOutTypeBtn: BatchButtonMedium12White!
    @IBOutlet weak var goalLblBtn: BatchButtonMedium12White!
    @IBOutlet weak var bottomBackView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomBackView.makeSpecificCornerRound(corners: .bottomTwo, radius: 20)

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
