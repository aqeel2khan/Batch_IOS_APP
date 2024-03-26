//
//  MealPlanAddressVC.swift
//  Batch
//
//  Created by Chawtech on 27/01/24.
//

import UIKit
import MapKit

class MealPlanAddressVC: UIViewController, UITextFieldDelegate {
    var completion: (() ->Void)? = nil

    var states: [States] = [] // Example states
    var cities: [City] = [] // Example cities by state

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var stateTextfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    var statePickerView: UIPickerView!
    var cityPickerView: UIPickerView!

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

        mapView.roundCorners(radius: 10)
        configureButtons()
        configureTextfieldsWithSelectedValues()
        
        getStatesList(countryId: "120")
    }
    
    func configureStateAndCityPickerView() {
        stateTextfield.inputView = createStatePickerView()
        stateTextfield.tag = 0 // Tag to identify state text field
        cityTextfield.inputView = createCityPickerView() // Default to first state
        cityTextfield.tag = 1 // Tag to identify city text field
    }
    
    // Create the state picker view
    func createStatePickerView() -> UIPickerView {
        statePickerView = UIPickerView()
        statePickerView.delegate = self
        statePickerView.dataSource = self
        return statePickerView
    }
    
    // Create the city picker view for a given state
    func createCityPickerView() -> UIPickerView {
        cityPickerView = UIPickerView()
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        return cityPickerView
    }

    
    func configureTextfieldsWithSelectedValues() {
        addressString1 = MealSubscriptionManager.shared.area ?? ""
        addressString2 = MealSubscriptionManager.shared.block ?? ""
        addressString3 = MealSubscriptionManager.shared.house ?? ""
        addressString4 = MealSubscriptionManager.shared.street ?? ""
        
        address1.text = addressString1
        address2.text = addressString2
        address3.text = addressString3
        address4.text = addressString4
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let textRange = Range(range, in: text) else {
            return true
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        switch textField {
        case address1:
            addressString1 = updatedText
        case address2:
            addressString2 = updatedText
        case address3:
            addressString3 = updatedText
        case address4:
            addressString4 = updatedText
        default:
            break
        }
        
        return true
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
        selectedButton = sender
        sender.backgroundColor = Colors.appViewPinkBackgroundColor
        
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
        setupDataAndDismiss()
    }
    
    func validateAddresses() -> (isValid: Bool, errorMessage: String) {
        
        if addressString1.isEmpty {
            return (false, "Area address is empty.")
        }
        
        if addressString2.isEmpty {
            return (false, "Block address is empty.")
        }
        
        if addressString3.isEmpty {
            return (false, "House address is empty.")
        }
        
        if addressString4.isEmpty {
            return (false, "Street address is empty.")
        }
        
        return (true, "")
    }

    func setupDataAndDismiss() {
        if !addressString1.isEmpty {
            MealSubscriptionManager.shared.area = addressString1
        }
        
        if !addressString2.isEmpty {
            MealSubscriptionManager.shared.block = addressString2
        }
        
        if !addressString3.isEmpty {
            MealSubscriptionManager.shared.house = addressString3
        }
        
        if !addressString4.isEmpty {
            MealSubscriptionManager.shared.street = addressString4
        }
        MealSubscriptionManager.shared.addressType = selectedDeliveryAddressType
        MealSubscriptionManager.shared.latitude = ""
        MealSubscriptionManager.shared.longitude = ""
        self.dismiss(animated: true)
        completion?()
    }
    @IBAction func btnApplyAction(_ sender: UIButton) {
        let validation = validateAddresses()
        
        if validation.isValid {
            // All addresses are non-empty
            setupDataAndDismiss()
        } else {
            // Show alert with errorMessage
            showAlert(message: validation.errorMessage)
        }
    }
}

extension MealPlanAddressVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == statePickerView {
            return states.count
        } else {
            return cities.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == statePickerView {
            return states[row].name
        } else {
            return cities[row].name
        }
    }
    
    // MARK: - UIPickerViewDelegate methods
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == statePickerView {
            let selectedState = states[row].name
            stateTextfield.text = selectedState
            self.updateTheSubscriptionManagerValue(city: nil, state: states[row])
            self.getCityList(stateId: "\(states[row].id)")
        } else {
            let selectedCity = cities[row].name
            cityTextfield.text = selectedCity
            self.updateTheSubscriptionManagerValue(city: cities[row], state: nil)
        }
    }
    
    func updateTheSubscriptionManagerValue(city: City?, state: States?) {
        if let city = city {
            MealSubscriptionManager.shared.city = city.name
            MealSubscriptionManager.shared.cityId = "\(city.id)"
        }
        
        if let state = state {
            MealSubscriptionManager.shared.state = state.name
            MealSubscriptionManager.shared.stateId = "\(state.id)"
        }
    }
}

extension MealPlanAddressVC {
    public func getStatesList(countryId: String) {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        bMealViewModel.getStatesList(request: StateRequest(countryId: countryId)) { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                DispatchQueue.main.async {
                    hideLoading()
                    self.states = response.data?.data ?? []
                    self.stateTextfield.text = self.states.first?.name
                    self.updateTheSubscriptionManagerValue(city: nil, state: self.states.first)
                    self.configureStateAndCityPickerView()
                    self.getCityList(stateId: "\(self.states.first?.id ?? 0)")
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.dismiss(animated: true)
                    self.showAlert(message: "Something Went wrong")
                }
            }
            
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.dismiss(animated: true)
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    public func getCityList(stateId: String) {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        bMealViewModel.getCityList(request: CityRequest(stateId: stateId)) { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                DispatchQueue.main.async {
                    hideLoading()
                    self.cities = response.data?.data ?? []
                    self.cityTextfield.text = self.cities.first?.name
                    self.updateTheSubscriptionManagerValue(city: self.cities.first, state: nil)
                    self.cityPickerView.reloadAllComponents()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.dismiss(animated: true)
                    self.showAlert(message: "Something Went wrong")
                }
            }
            
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.dismiss(animated: true)
                self.showAlert(message: error.localizedDescription)
            }
        }
    }

}
