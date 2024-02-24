//
//  CountryListTableCell.swift
//  DemoPractice
//
//  Created by shashivendra sengar on 21/02/24.
//

import UIKit

class CountryListTableCell: UITableViewCell {

    @IBOutlet weak var backGroundUIView: UIView!

    @IBOutlet weak var lblCountryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
