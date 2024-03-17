//
//  BRegistrationVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 30/01/24.
//

import UIKit

class BRegistrationVC: UIViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    var promotionPriceValue = 0.0
    var selectedSubscriptionInfo = [CourseDataList]()

    var isCommingFrom = ""
    var isCheckBoxSelected = false
    var mealData : Meals!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpLocalization()
    }
    
    //MARK:- SetUp Localization
    
    func setUpLocalization() {
        /*
        self.lblTermCondition.text = "I agree to the company Terms & Conditions".localized()
        self.btnSignIn.setTitle("Sign In".localized(), for: .normal)
        self.btnFbLogin.setTitle("Sign in with Facebook".localized(), for: .normal)
        self.btnAppleLogin.setTitle("Sign in with Apple".localized(), for: .normal)
        self.btnGoogleLogin.setTitle("Sign in with Google".localized(), for: .normal)
        self.btnOutlookLogin.setTitle("Sign in with Outlook".localized(), for: .normal)
         */
    }
    
    @IBAction func onTapWithGoogleSignUpBtn(_ sender: UIButton) {
    }
    @IBAction func onTapWithOutLookSignUpBtn(_ sender: UIButton) {
    }
    @IBAction func onTapWithFacebookSignUpBtn(_ sender: UIButton) {
    }
    @IBAction func onTapWithAppleSignUpBtn(_ sender: UIButton) {
    }
    
    
    @IBAction func onTapCheckBoxBtn(_ sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
        isCheckBoxSelected = sender.isSelected
    }
    
    
    @IBAction func onTapGoToCheckOutBtn(_ sender: Any) {
//        let vc = MealPlanCheckout.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
//        vc.modalPresentationStyle = .overFullScreen
//        vc.modalTransitionStyle = .coverVertical
//        self.present(vc, animated: true)
        
        if isCheckBoxSelected == true
        {
            if internetConnection.isConnectedToNetwork() == true {
                self.signUpApi()
            }else{
                self.showAlert(message: "Please check your internet", title: "Network issue")
            }
        }
        else
        {
            showAlert(message: "Please select terms and conditions checkbox".localized)
        }
    }
    
    @IBAction func onTapPassowrdEyeBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
    }
    
    private func signUpApi(){
        let email = (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        let password = (passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        let name = (fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        let mobile = (phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        
        let request = BRegistrationRequest(email: "\(email)", password: "\(password)", mobile: "\(mobile)", name: "\(name)")
        DispatchQueue.main.async {
            showLoading()
        }
        let bRegistrationViewModel = BRegistrationViewModel()
        bRegistrationViewModel.registrationApi(request: request) { (response) in
            if response.status == true {
                DispatchQueue.main.async {
                    hideLoading()
                    Batch_UserDefaults.set(response.data?.id, forKey: UserDefaultKey.USER_ID)
                    Batch_UserDefaults.set(response.token ?? "" , forKey: UserDefaultKey.TOKEN)
                    let getToken = Batch_UserDefaults.value(forKey: UserDefaultKey.TOKEN)
                    print(getToken)
                    UserDefaultUtility.setUserLoggedIn(true)

                    if self.isCommingFrom == "workoutbatches" {
                        let vc = BCheckoutVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .coverVertical
                        vc.promotionPriceValue = 0
                        vc.selectedSubscriptionInfo = [self.selectedSubscriptionInfo[0]]
                        vc.isCommingFrom = self.isCommingFrom
                        self.present(vc, animated: true)
                    }
                    if self.isCommingFrom == "MealBatchSubscribe" {
                        let vc = MealPlanCheckout.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
                        vc.isCommingFrom = "MealBatchSubscribe"
                        vc.mealData = self.mealData
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .coverVertical
                        self.present(vc, animated: true)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.showAlert(message: response.message ?? "")
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: "\(error.localizedDescription)")
            }
        }
    }
}
