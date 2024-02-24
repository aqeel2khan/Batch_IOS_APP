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
    @IBOutlet weak var passwordTextField: UITextField!

    
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
    
    @IBAction func onTapPassowrdEyeBtn(_ sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry

    }
    
    private func signUpApi(email:String, password:String, mobile:String,name:String){
        
        let request = BRegistrationRequest(email: "\(email)", password: "\(password)", mobile: "\(mobile)", name: "\(name)")
        DispatchQueue.main.async {
            showLoading()
        }
        let bPromoCodePopUpViewModel = BRegistrationViewModel()
        let urlStr = API.signUp
        bPromoCodePopUpViewModel.registrationApi(request: request) { (response) in
            
            if response.status == true {
                print(response.data)
                // self.blogsArray = response.data!
                DispatchQueue.main.async {
                    hideLoading()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    //makeToast(response.message!)
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                // makeToast(error.localizedDescription)
            }
        }
    }
    
    
}
