//
//  MealPlanIngridentTableCell.swift
//  Batch
//
//  Created by Chawtech on 28/01/24.
//

import UIKit

class MealPlanIngridentTableCell: UITableViewCell {

    @IBOutlet weak var imgSelctIngrident: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = FontSize.mediumSize16
    }
}
