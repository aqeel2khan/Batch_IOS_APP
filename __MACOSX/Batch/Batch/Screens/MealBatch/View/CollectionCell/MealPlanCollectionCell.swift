//
//  MealPlanCollectionCell.swift
//  Batch
//
//  Created by shashivendra sengar on 11/01/24.
//

import UIKit

class MealPlanCollectionCell: UICollectionViewCell {

    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var imageBackGrd: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
         titleView.makeSpecificCornerRound(corners: .topTwo, radius: 20)
         imageBackGrd.makeSpecificCornerRound(corners: .topTwo, radius: 20)
         */

//        titleView.cornerRadius = 20
//        imageBackGrd.cornerRadius = 20
    }

}
