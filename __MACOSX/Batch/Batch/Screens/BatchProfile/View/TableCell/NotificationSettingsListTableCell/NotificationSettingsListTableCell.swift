//
//  TrainingListTableCell.swift
//  Batch
//
//  Created by shashivendra sengar on 20/12/23.
//

import UIKit

class NotificationSettingsListTableCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var switchBtn: UISwitch!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = FontSize.mediumSize18
    }
}
