//
//  BatchTrainingDetailCollCell.swift
//  Batch
//
//  Created by shashivendra sengar on 20/12/23.
//

import UIKit

class BatchTrainingDetailCollCell: UICollectionViewCell {

    @IBOutlet weak var imgWorkOut: UIImageView!
    @IBOutlet weak var lblWorkoutName: UILabel!
    @IBOutlet weak var backGroundUIView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        lblWorkoutName.font = FontSize.mediumSize12
//        lblWorkoutName.textColor = Colors.appLabelDarkGrayColor
        backGroundUIView.cornerRadius = 14
        backGroundUIView.backgroundColor = Colors.appViewPinkBackgroundColor
    }
}
