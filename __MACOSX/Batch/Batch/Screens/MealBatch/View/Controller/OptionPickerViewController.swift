//
//  OptionPickerViewController.swift
//  Batch
//
//  Created by Krupanshu Sharma on 17/03/24.
//

import UIKit

protocol OptionPickerDelegate: AnyObject {
    func didSelectOption(_ option: String)
}

class OptionPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerOptions: [String] = []
    weak var delegate: OptionPickerDelegate?
    
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
        delegate?.didSelectOption(selectedOption ?? "")
    }
    
    @IBAction func backactionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

}
