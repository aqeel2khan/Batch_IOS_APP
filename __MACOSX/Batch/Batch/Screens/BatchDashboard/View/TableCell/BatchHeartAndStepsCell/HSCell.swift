//
//  HSCell.swift
//  Batch
//
//  Created by Vijay Singh on 11/03/24.
//

import UIKit

class HSCell: UITableViewCell {

    @IBOutlet weak var heartRateLabel: UILabel!
    @IBOutlet weak var stepsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
