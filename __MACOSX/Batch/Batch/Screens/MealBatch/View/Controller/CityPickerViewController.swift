//
//  CityPickerViewController.swift
//  Batch
//
//  Created by Krupanshu Sharma on 24/03/24.
//

import UIKit

protocol CityPickerDelegate: AnyObject {
    func didSelectCity(_ option: String)
}


class CityPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var pickerOptions: [String] = []
    weak var delegate: CityPickerDelegate?
    
    @IBOutlet weak var pickerTitle: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var selectedOption: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    // MARK: - UIPickerViewDataSource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerOptions.count
    }
    
    // MARK: - UIPickerViewDelegate methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = pickerOptions[row]
    }
    
    @IBAction func btnApplyAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        delegate?.didSelectCity(selectedOption ?? "")
    }
    
    @IBAction func backactionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}
