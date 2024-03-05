//
//  BMealTblCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import UIKit

class BMealTblCell: UITableViewCell {

    
    @IBOutlet weak var sectionTitleLbl: BatchLabelSubTitleBlack!
    @IBOutlet weak var dishName: BatchLabelSubTitleBlack!
    @IBOutlet weak var dishCalory: BatchMediumDarkGray!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
