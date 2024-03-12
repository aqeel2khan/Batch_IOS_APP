//
//  CountryListTableCell.swift
//  DemoPractice
//
//  Created by shashivendra sengar on 21/02/24.
//

import UIKit

class CountryListTableCell: UITableViewCell {
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var radioImageView: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK Methods
    func configure(selected: Bool) {
        if selected {
            radioImageView.image = UIImage.init(named: "right_icon")
        } else {
            radioImageView.image = UIImage.init(named: "radio_empty")
        }
    }
}
