//
//  ButtonWithImage.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import UIKit

class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: (bounds.width - 35), bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: (imageView?.frame.width)!)
        }
    }
}
