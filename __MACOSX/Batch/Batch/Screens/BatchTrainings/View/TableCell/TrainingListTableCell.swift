//
//  TrainingListTableCell.swift
//  Batch
//
//  Created by shashivendra sengar on 20/12/23.
//

import UIKit

class TrainingListTableCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: BatchMedium18Black!
    @IBOutlet weak var lblMints: BatchLabelMedium18DarkGray!
    @IBOutlet weak var lblKalori: BatchLabelMedium18DarkGray!
    
    @IBOutlet weak var backgrounView: UIView!
    
    @IBOutlet weak var imgTime: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var imgKaloriImage: UIImageView!
    
    @IBOutlet weak var bottomStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.font = FontSize.mediumSize18
        lblMints.font = FontSize.regularSize14
        lblKalori.font = FontSize.regularSize14
        lblTitle.textColor = Colors.appLabelDarkGrayColor
        lblMints.textColor = Colors.appLabelDarkGrayColor
        lblKalori.textColor = Colors.appLabelDarkGrayColor
        backgrounView.cornerRadius = 10
        backgrounView.backgroundColor = Colors.appViewBackgroundColor
    }
}
