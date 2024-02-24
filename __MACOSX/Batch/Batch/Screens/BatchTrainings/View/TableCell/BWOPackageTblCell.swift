//
//  BWOPackageTblCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import UIKit

class BWOPackageTblCell: UITableViewCell {

    @IBOutlet weak var cellBtn: UIButton!
    
    @IBOutlet weak var courseLevelTypeLbl: UIButton!
    
    
    
    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var woDayCountLbl: UILabel!
    @IBOutlet weak var coachProfileImg: UIImageView!
    @IBOutlet weak var coachNameLbl: UILabel!

    @IBOutlet weak var workOutTypeBtn: UIButton!
    
    @IBOutlet weak var goalLblBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
