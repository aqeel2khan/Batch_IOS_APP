//
//  BUserGenderVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 19/12/23.
//

import UIKit
import SDWebImage

class BUserDeleteAccountVC: UIViewController {
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var descTextView: UITextView!
    var mobileStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
        mobileNumberTextField.text = mobileStr
        descTextView.textContainerInset = UIEdgeInsets(top: 5,left: 5,bottom: 5,right: 5)
    }
    
    @IBAction func deleteAccountBtnTap(_ sender: Any) {
        if mobileNumberTextField.text == "" {
            self.showAlert(message: "Please enter mobile number".localized)
        } else if descTextView.text == "" {
            self.showAlert(message: "Please enter reason to delete your account".localized)
        } else {
            let alertController  = UIAlertController(title: "", message: "Your request has been sent your account will be deleted in 15 days".localized, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Okay".localized, style: .default, handler: { _ in
                Batch_UserDefaults.removeObject(forKey: USER_DEFAULTS_KEYS.USER_NAME)
                Batch_UserDefaults.removeObject(forKey: UserDefaultKey.TOKEN)
                Batch_UserDefaults.setValue(nil, forKey: UserDefaultKey.profilePhoto)
                Batch_UserDefaults.setValue(false, forKey: UserDefaultKey.healthPermission)
                UserDefaultUtility.setUserLoggedIn(false)
                SDImageCache.shared.clearMemory()
                SDImageCache.shared.clearDisk()
                
                let tabbarVC = UIStoryboard(name: "BatchTabBar", bundle: nil).instantiateViewController(withIdentifier: "BatchTabBarNavigation")
                tabbarVC.modalPresentationStyle = .fullScreen
                AppDelegate.standard.window?.rootViewController = tabbarVC
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }

    @IBAction func dismissBtnTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
