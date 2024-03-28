//
//  TrainingListTableCell.swift
//  Batch
//
//  Created by shashivendra sengar on 20/12/23.
//

import UIKit

class NotificationListTableCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = FontSize.mediumSize14
    }
}
