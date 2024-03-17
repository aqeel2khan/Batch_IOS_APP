//
//  BMealCategoryCollCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 28/01/24.
//

import UIKit

class BMealCategoryCollCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                UIView.animate(withDuration: 0.3) { // for animation effect
                    self.bgView.backgroundColor = Colors.appViewPinkBackgroundColor
                }
            }
            else {
                UIView.animate(withDuration: 0.3) { // for animation effect
                    self.bgView.backgroundColor = Colors.appViewBackgroundColor
                }
            }
        }
    }

}
