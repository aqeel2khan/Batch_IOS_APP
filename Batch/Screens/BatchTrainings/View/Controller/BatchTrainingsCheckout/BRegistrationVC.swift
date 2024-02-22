//
//  BRegistrationVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 30/01/24.
//

import UIKit

class BRegistrationVC: UIViewController {
    
    @IBOutlet weak var fullNameLbl: UITextField!
    @IBOutlet weak var phoneLbl: UITextField!
    @IBOutlet weak var emailLbl: UITextField!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func onTapWithGoogleSignUpBtn(_ sender: UIButton) {
    }
    @IBAction func onTapWithOutLookSignUpBtn(_ sender: UIButton) {
    }
    @IBAction func onTapWithFacebookSignUpBtn(_ sender: UIButton) {
    }
    @IBAction func onTapWithAppleSignUpBtn(_ sender: UIButton) {
    }
    
    
    
    
    
    
    @IBAction func onTapGoToCheckOutBtn(_ sender: Any) {
        let vc = MealPlanCheckout.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }

}
