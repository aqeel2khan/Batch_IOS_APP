//
//  BMealTblCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import UIKit

class QuestionLabelTVC: UITableViewCell {

    @IBOutlet weak var titleLbl: BatchRegularBlack!
    @IBOutlet weak var questionUIView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
