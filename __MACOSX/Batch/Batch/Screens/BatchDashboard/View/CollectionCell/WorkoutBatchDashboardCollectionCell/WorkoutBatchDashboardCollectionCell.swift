//
//  MealPlanCollectionCell.swift
//  Batch
//
//  Created by shashivendra sengar on 11/01/24.
//

import UIKit

class WorkoutBatchDashboardCollectionCell: UICollectionViewCell {
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var daysLbl: UILabel!
    @IBOutlet weak var kclLbl: UILabel!
    @IBOutlet weak var minLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
