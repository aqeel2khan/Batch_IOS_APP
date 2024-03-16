//
//  MealDilevaryDropOffVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 30/01/24.
//

import UIKit

class MealDilevaryDropOffVC: UIViewController {
    
    @IBOutlet var mainView: UIView!
    var deliveryDropOffOptions : [DeliveryDropOffOption] = []
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    var selectedButton: UIButton?
    var selectedDeliveryDropOffOption: DeliveryDropOffOption?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        self.getDeliveryDropOffOptions()

    }
    
    // Function to configure the buttons
    func configureButtons() {
        button1.layer.cornerRadius = 10
        button2.layer.cornerRadius = 10
        button3.layer.cornerRadius = 10
        
        button1.setTitle("", for: .normal)
        button2.setTitle("", for: .normal)
        button3.setTitle("", for: .normal)
        
        button1.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button3.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
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
        if sender == button1 {
            // Handle button 1 selection
            selectedDeliveryDropOffOption = self.deliveryDropOffOptions[0]
        } else if sender == button2 {
            // Handle button 2 selection
            selectedDeliveryDropOffOption = self.deliveryDropOffOptions[1]
        } else if sender == button3 {
            // Handle button 3 selection
            selectedDeliveryDropOffOption = self.deliveryDropOffOptions[2]
        }
    }

    
    func getDeliveryDropOffOptions() {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealCoViewModel = BMealPlanCheckoutViewModel()
        let urlStr = API.deliveryDropOffList
        bMealCoViewModel.getDeliveryDropOffSlots(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                self.deliveryDropOffOptions.removeAll()
                self.deliveryDropOffOptions = response.data?.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.button1.setTitle(self.deliveryDropOffOptions[0].options, for: .normal)
                    self.button2.setTitle(self.deliveryDropOffOptions[1].options, for: .normal)
                    self.button3.setTitle(self.deliveryDropOffOptions[2].options, for: .normal)
                    self.buttonTapped(self.button1)
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
            }
        }
    }

    @IBAction func backactionBtn(_ sender: UIButton) {
        MealSubscriptionManager.shared.deliveryDropoff = selectedDeliveryDropOffOption?.options
        MealSubscriptionManager.shared.deliveryDropoffId = selectedDeliveryDropOffOption?.id
        self.dismiss(animated: true)
    }
    
    @IBAction func btnApplyAction(_ sender: UIButton) {
        MealSubscriptionManager.shared.deliveryDropoff = selectedDeliveryDropOffOption?.options
        MealSubscriptionManager.shared.deliveryDropoffId = selectedDeliveryDropOffOption?.id
        self.dismiss(animated: true)
    }
}
