//
//  MealDilevaryArrivingVC.swift
//  Batch
//
//  Created by Chawtech on 27/01/24.
//

import UIKit

class MealDilevaryArrivingVC: UIViewController {
    var completion: (() ->Void)? = nil

    @IBOutlet var mainView: UIView!
    var deliveryArrivingOptions : [DeliveryArrivingOption] = []

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    var selectedButton: UIButton?
    var selectedDeliveryOption: DeliveryArrivingOption?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Configure buttons
        configureButtons()
        self.getDeliveryArrivingOptions()
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
            selectedDeliveryOption = self.deliveryArrivingOptions[0]
        } else if sender == button2 {
            // Handle button 2 selection
            selectedDeliveryOption = self.deliveryArrivingOptions[1]
        } else if sender == button3 {
            // Handle button 3 selection
            selectedDeliveryOption = self.deliveryArrivingOptions[2]
        }
    }

    @IBAction func backactionBtn(_ sender: UIButton) {
        setupDataAndDismiss()
    }
    func setupDataAndDismiss() {
        MealSubscriptionManager.shared.deliveryArriving = selectedDeliveryOption?.options
        MealSubscriptionManager.shared.deliveryArrivingId = selectedDeliveryOption?.id
        self.dismiss(animated: true)
        completion?()
    }

    @IBAction func btnApplyAction(_ sender: UIButton) {
        setupDataAndDismiss()
    }

    func getDeliveryArrivingOptions() {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealCoViewModel = BMealPlanCheckoutViewModel()
        let urlStr = API.deliveryArrivingList
        bMealCoViewModel.getDeliveryArrivingSlots(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                self.deliveryArrivingOptions.removeAll()
                self.deliveryArrivingOptions = response.data?.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.button1.setTitle(self.deliveryArrivingOptions[0].options, for: .normal)
                    self.button2.setTitle(self.deliveryArrivingOptions[1].options, for: .normal)
                    self.button3.setTitle(self.deliveryArrivingOptions[2].options, for: .normal)
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
}
