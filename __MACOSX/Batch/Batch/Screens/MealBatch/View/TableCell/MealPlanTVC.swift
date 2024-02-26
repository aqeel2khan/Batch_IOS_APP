//
//  MealPlanTVC.swift
//  Batch
//
//  Created by shashivendra sengar on 09/01/24.
//

import UIKit

class MealPlanTVC: UITableViewCell {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var kclLbl: UILabel!
    @IBOutlet weak var mealsLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        /*
         titleView.makeSpecificCornerRound(corners: .topTwo, radius: 20)
         backGroundImage.makeSpecificCornerRound(corners: .topTwo, radius: 20)
         */
    }


    
}
