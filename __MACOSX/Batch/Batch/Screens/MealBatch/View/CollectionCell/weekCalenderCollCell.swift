//
//  weekCalenderCollCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import UIKit

class weekCalenderCollCell: UICollectionViewCell {
    
    @IBOutlet weak var weekDayNameLbl: UILabel!
    @IBOutlet weak var weekDateLbl: BatchLabelMedium14DarkGray!
    @IBOutlet weak var greenDotImgView: UIImageView!
    var isRenderingFromMealCalendarScreen = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.weekDateLbl.layer.cornerRadius = (self.weekDateLbl.frame.width)/2
        self.weekDateLbl.clipsToBounds = true
    }

    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                UIView.animate(withDuration: 0.3) { // for animation effect
                    if self.isRenderingFromMealCalendarScreen {
                        self.weekDateLbl.backgroundColor = UIColor(red: 241/255, green: 230/255, blue: 218/255, alpha: 1.0)
                    } else {
                        self.weekDateLbl.backgroundColor = UIColor(red: 204/255, green: 222/255, blue: 193/255, alpha: 1.0)
                    }
                }
            }
            else {
                UIView.animate(withDuration: 0.3) { // for animation effect
                    self.weekDateLbl.backgroundColor = UIColor.clear
                }
            }
        }
    }
}
