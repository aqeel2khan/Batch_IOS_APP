//
//  MealPlanCollectionCell.swift
//  Batch
//
//  Created by shashivendra sengar on 11/01/24.
//

import UIKit

class MealBatchDashboardCollectionCell: UICollectionViewCell {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var imageBackGrd: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var daysLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        /*
         titleView.makeSpecificCornerRound(corners: .topTwo, radius: 20)
         imageBackGrd.makeSpecificCornerRound(corners: .topTwo, radius: 20)
         */
    }
}
