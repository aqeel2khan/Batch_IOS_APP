//
//  ReviewIngridentCollectionViewCell.swift
//  Batch
//
//  Created by Chawtech on 28/01/24.
//

import UIKit

class ReviewIngridentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgImage: UIImageView!
    
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelReviewDescription: UILabel!
    @IBOutlet weak var rating: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgImage.makeRounded()
    }
}
