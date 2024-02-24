//
//  BWOMotivatorsListCollCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 17/12/23.
//

import UIKit

class BWOMotivatorsListCollCell: UICollectionViewCell {
    
    @IBOutlet weak var imageMotivatorUser: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    private func setupView()
    {
        self.nameLbl.font = FontSize.mediumSize16
        self.nameLbl.textColor = Colors.appLabelBlackColor
        
        self.typeLbl.font = FontSize.regularSize14
        self.typeLbl.textColor = Colors.appLabelDarkGrayColor
        
    }

}
