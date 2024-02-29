//
//  PaymentMethodTblViewCell.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 29/02/24.
//

import UIKit
import MFSDK

class PaymentMethodTblViewCell: UITableViewCell {
    
    //MARK: Variables
    
    //MARK: Outlets
    @IBOutlet weak var paymentMethodImageView: UIImageView!
    @IBOutlet weak var paymentMethodNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK Methods
    func configure(paymentMethod: MFPaymentMethod, selected: Bool) {
        paymentMethodImageView.image = nil
        paymentMethodImageView.layer.cornerRadius = 5
        if selected {
            if #available(iOS 13.0, *) {
                paymentMethodImageView.layer.borderColor = UIColor.label.cgColor
            } else {
                paymentMethodImageView.layer.borderColor = UIColor.black.cgColor
            }
            paymentMethodImageView.layer.borderWidth = 3
        } else {
            paymentMethodImageView.layer.borderWidth = 0
        }
        if let imageURL = paymentMethod.imageUrl {
            paymentMethodImageView.downloaded(from: imageURL)
        }
        paymentMethodNameLabel.text = paymentMethod.paymentMethodEn ?? ""
    }
}
