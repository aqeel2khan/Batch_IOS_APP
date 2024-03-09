//
//  MealPlanProtienCollectionViewCell.swift
//  Batch
//
//  Created by Chawtech on 28/01/24.
//

import UIKit

class MealPlanProtienCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var claoryview: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        claoryview.layer.cornerRadius = 20
        mainView.layer.cornerRadius = 20
    }

}
