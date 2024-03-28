//
//  MealPlanCollectionCell.swift
//  Batch
//
//  Created by shashivendra sengar on 11/01/24.
//

import UIKit

class MealPlanCollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: BatchLabelRegularWhite!
    @IBOutlet weak var kclLbl: UILabel!
    @IBOutlet weak var mealsLbl: UILabel!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}
