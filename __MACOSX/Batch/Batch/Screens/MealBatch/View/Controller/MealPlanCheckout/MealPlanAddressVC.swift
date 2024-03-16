//
//  MealPlanAddressVC.swift
//  Batch
//
//  Created by Chawtech on 27/01/24.
//

import UIKit

class MealPlanAddressVC: UIViewController, UITextFieldDelegate {
    var completion: (() ->Void)? = nil

    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var address1: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var address3: UITextField!
    @IBOutlet weak var address4: UITextField!
    @IBOutlet weak var isDefaultAddress: UISwitch!
    @IBOutlet weak var buttonHome: UIButton!
    @IBOutlet weak var buttonOffice: UIButton!

    var selectedButton: UIButton?
    var selectedDeliveryAddressType: String?

    var addressString1: String = ""
    var addressString2: String = ""
    var addressString3: String = ""
    var addressString4: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        address1.delegate = self
        address2.delegate = self
        address3.delegate = self
        address4.delegate = self

        configureButtons()
    }
    // Action method for switch to handle state changes
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        // Handle switch state change
        if sender.isOn {
            // Switch is on
        } else {
            // Switch is off
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == address1 {
            addressString1 = textField.text ?? ""
        } else if textField == address2 {
            addressString2 = textField.text ?? ""
        } else if textField == address3 {
            addressString3 = textField.text ?? ""
        } else if textField == address4 {
            addressString4 = textField.text ?? ""
        }
    }
    
    func configureButtons() {
        buttonHome.layer.cornerRadius = 10
        buttonOffice.layer.cornerRadius = 10
            
        buttonHome.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        buttonOffice.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        buttonTapped(buttonHome)
    }
    
    // Action method for button tap
    @objc func buttonTapped(_ sender: UIButton) {
        // Deselect previously selected button
        selectedButton?.isSelected = false
        selectedButton?.backgroundColor = Colors.appViewBackgroundColor
        
        // Select the tapped button
        sender.backgroundColor = Colors.appViewPinkBackgroundColor
        selectedButton = sender
        
        // Perform actions based on the selected button
        if sender == buttonHome {
            // Handle button 1 selection
            selectedDeliveryAddressType = "Home"
        } else if sender == buttonOffice {
            // Handle button 2 selection
            selectedDeliveryAddressType = "Office"
        }
    }


    @IBAction func backActionBtn(_ sender: UIButton) {
        MealSubscriptionManager.shared.area = addressString1
        MealSubscriptionManager.shared.block = addressString2
        MealSubscriptionManager.shared.house = addressString3
        MealSubscriptionManager.shared.street = addressString4
        MealSubscriptionManager.shared.addressType = selectedDeliveryAddressType
        MealSubscriptionManager.shared.latitude = ""
        MealSubscriptionManager.shared.longitude = ""

        self.dismiss(animated: true)
    }
    
    @IBAction func btnApplyAction(_ sender: UIButton) {
        
        MealSubscriptionManager.shared.area = addressString1
        MealSubscriptionManager.shared.block = addressString2
        MealSubscriptionManager.shared.house = addressString3
        MealSubscriptionManager.shared.street = addressString4
        MealSubscriptionManager.shared.addressType = selectedDeliveryAddressType
        MealSubscriptionManager.shared.latitude = ""
        MealSubscriptionManager.shared.longitude = ""
        self.dismiss(animated: true)
        completion?()

    }
}
