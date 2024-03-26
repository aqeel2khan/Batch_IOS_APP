//
//  BMealTblCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import UIKit

class BMealTblCell: UITableViewCell {

    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var sectionTitleLbl: UILabel!
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishCalory: BatchMediumDarkGray!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sectionTitleLbl.font = FontSize.mediumSize16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
