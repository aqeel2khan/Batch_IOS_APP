//
//  BUserGenderVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 19/12/23.
//

import UIKit

class BUserPersonalInfoVC: UIViewController {
    @IBOutlet var mainView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    
    
    //    func setUpLocalization(){
    //        self.lblSubTitle.text = "Before we start, we need to know your gender".localized()
    //        self.lblTitle.text = "Welcome to Batch!".localized()
    //
    //        self.lblAlreadyHaveAccount.text = "Already have an account?  Sign In".localized()
    //        self.btnContinue.setTitle("Continue".localized(), for: .normal)
    //        self.lblFemale.text = "Female".localized()
    //        self.lblMale.text = "Male".localized()
    //
    //    }
    
    @IBAction func onTapBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapSaveBtn(_ sender: UIButton) {
     
    }
}
