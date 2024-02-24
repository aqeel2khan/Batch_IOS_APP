//
//  MealPlanTVC.swift
//  Batch
//
//  Created by shashivendra sengar on 09/01/24.
//

import UIKit

class MealPlanTVC: UITableViewCell {
    
    @IBOutlet weak var btnMealPlan: UIButton!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
         titleView.makeSpecificCornerRound(corners: .topTwo, radius: 20)
         backGroundImage.makeSpecificCornerRound(corners: .topTwo, radius: 20)
         */
        titleView.cornerRadius = 20
        backGroundImage.cornerRadius = 20
    }


    
}
