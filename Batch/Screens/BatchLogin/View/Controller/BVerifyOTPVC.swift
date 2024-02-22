//
//  BVerifyOTPVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 19/12/23.
//

import UIKit
import SGCodeTextField

class BVerifyOTPVC: UIViewController {
 
    @IBOutlet weak var btnContinue: BatchButton!
    
    @IBOutlet weak var codeTextField: SGCodeTextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        //SetUpLocalization()
        
        self.codeTextField.count = 4
        self.codeTextField.placeholder = ""
        self.codeTextField.refreshUI()
        
    }
    
    //MARK:- SetUp Localization
    
    func SetUpLocalization(){
        //self.lblTitle.text = "Enter verification code".localized()
        //self.lblSubTitle.text = "We have sent the code verification to your mobile number ".localized()
        //self.btnContinue.setTitle("Continue".localized(), for: .normal)
    }
    
    @IBAction func onTapContinueBtn(_ sender: Any) {
        let vc = BUserGenderVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onTapBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
