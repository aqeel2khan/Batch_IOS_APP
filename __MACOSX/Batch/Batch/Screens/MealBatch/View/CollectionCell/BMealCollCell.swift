//
//  BMealCollCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import UIKit

class BMealCollCell: UICollectionViewCell {

    @IBOutlet weak var bottomBackView: UIView!
    @IBOutlet weak var radioBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bottomBackView.makeSpecificCornerRound(corners: .bottomTwo, radius: 20)

    }

}
