//
//  BatchTabBar.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import UIKit

class BatchTabBar: UITabBar {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
    }
    
    private func addShadow() {
        layer.shadowOffset = CGSize(width: 0, height: -3)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 5
        layer.masksToBounds = false
    }
}
