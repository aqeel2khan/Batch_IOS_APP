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
    @IBOutlet weak var radioImageView: UIImageView!

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
            radioImageView.image = UIImage.init(named: "radio_fill")
//            paymentMethodImageView.layer.borderWidth = 3
        } else {
            radioImageView.image = UIImage.init(named: "radio_empty")
//            paymentMethodImageView.layer.borderWidth = 0
        }
        if let imageURL = paymentMethod.imageUrl {
            paymentMethodImageView.downloaded(from: imageURL)
        }
        
        let languageCode = UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE) as? String ?? DEFAULT_LANGUAGE_CODE
        if languageCode == ENGLISH_LANGUAGE_CODE {
            paymentMethodNameLabel.text = paymentMethod.paymentMethodEn ?? ""
        } else {
            paymentMethodNameLabel.text = paymentMethod.paymentMethodAr ?? ""
        }
    }
}
