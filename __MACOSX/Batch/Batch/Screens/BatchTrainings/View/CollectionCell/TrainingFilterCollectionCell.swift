//
//  TrainingFilterCollectionCell.swift
//  Batch
//
//  Created by shashivendra sengar on 17/12/23.
//

import UIKit

class TrainingFilterCollectionCell: UICollectionViewCell {

    @IBOutlet weak var lblWorkoutName: UILabel!
    @IBOutlet weak var backGroundUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblWorkoutName.font = FontSize.regularSize16
        lblWorkoutName.textColor = Colors.appLabelDarkGrayColor
        backGroundUIView.cornerRadius = 10
        backGroundUIView.backgroundColor = Colors.appViewBackgroundColor

    }

}
