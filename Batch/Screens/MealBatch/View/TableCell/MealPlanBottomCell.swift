//
//  MealPlanBottomCell.swift
//  Batch
//
//  Created by shashivendra sengar on 12/01/24.
//

import UIKit

class MealPlanBottomCell: UITableViewCell {
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var calculateBtn: BatchButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleView.cornerRadius = 20
    }
    
    
    
}
