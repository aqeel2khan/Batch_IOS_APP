//
//  ReviewIngridentCollectionViewCell.swift
//  Batch
//
//  Created by Chawtech on 28/01/24.
//

import UIKit

class ReviewIngridentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgImage.makeRounded()
    }
}
