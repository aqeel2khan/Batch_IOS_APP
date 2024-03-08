//
//  BWOBatchesListCollCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 17/12/23.
//

import UIKit

class BWOBatchesListCollCell: UICollectionViewCell {
    
    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var woDayCountLbl: UILabel!
    @IBOutlet weak var coachProfileImg: UIImageView!
    @IBOutlet weak var courseLevelTypeLbl: UIButton!
    @IBOutlet weak var coachNameLbl: UILabel!
    @IBOutlet weak var workOutTypeBtn: UIButton!
    @IBOutlet weak var goalLblBtn: UIButton!
    
    
    @IBOutlet weak var bottomBackView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomBackView.makeSpecificCornerRound(corners: .bottomTwo, radius: 20)

    }

}
