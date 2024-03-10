//
//  BMealCollCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import UIKit

class BMealDishCollCell: UICollectionViewCell {

    @IBOutlet weak var bottomBackView: UIView!
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var kclLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomBackView.makeSpecificCornerRound(corners: .bottomTwo, radius: 20)
        nameLbl.font = FontSize.mediumSize14
    }
}
