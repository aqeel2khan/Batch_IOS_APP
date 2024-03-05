//
//  Extension+BUserPersonalInfo.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation
import UIKit

extension BUserPersonalInfoVC: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveBtn.setTitle("Save", for: .normal)
    }
}
