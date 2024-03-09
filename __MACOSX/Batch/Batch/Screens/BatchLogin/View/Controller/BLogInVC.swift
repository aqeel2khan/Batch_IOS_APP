//
//  BLogInVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 19/12/23.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class BLogInVC: UIViewController {
    
    @IBOutlet weak var lblTermCondition: UILabel!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnFbLogin: BatchButton!
    @IBOutlet weak var btnAppleLogin: BatchButton!
    @IBOutlet weak var btnGoogleLogin: BatchButton!
    @IBOutlet weak var btnOutlookLogin: BatchButton!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    var promotionPriceValue = 0.0
    var selectedSubscriptionInfo = [CourseDataList]()
    
    var isCommingFrom = ""
    var isCheckBoxSelected = false
    var mealData : Meals!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocalization()
    }
    
    //MARK:- SetUp Localization
    
    func setUpLocalization() {
        
        self.lblTermCondition.text = "I agree to the company Terms & Conditions".localized()
        self.btnSignIn.setTitle("Sign In".localized(), for: .normal)
        self.btnFbLogin.setTitle("Sign in with Facebook".localized(), for: .normal)
        self.btnAppleLogin.setTitle("Sign in with Apple".localized(), for: .normal)
        self.btnGoogleLogin.setTitle("Sign in with Google".localized(), for: .normal)
        self.btnOutlookLogin.setTitle("Sign in with Outlook".localized(), for: .normal)
    }
    
    @IBAction func onTapCheckBoxBtn(_ sender: UIButton)
    {
        
        sender.isSelected = !sender.isSelected
        isCheckBoxSelected = sender.isSelected
        // self.userEmailTextField.isSecureTextEntry = !self.userEmailTextField.isSecureTextEntry
    }
    @IBAction func onTapPassowrdEyeBtn(_ sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
        self.passwordTextField.isSecureTextEntry = !self.passwordTextField.isSecureTextEntry
        
    }
    
    
    @IBAction func onTapSignInBtn(_ sender: Any) {
        //        //        GIDSignIn.sharedInstance.signOut()
        //
        //        let vc = BVerifyOTPVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
        //        vc.modalPresentationStyle = .overFullScreen
        //        vc.modalTransitionStyle = .crossDissolve
        //        self.present(vc, animated: true)
        if isCheckBoxSelected == true
        {
            if internetConnection.isConnectedToNetwork() == true {
                self.logInApi()
            }else{
                self.showAlert(message: "Please check your internet", title: "Network issue")
            }
        }
        else
        {
            showAlert(message: "Please select terms and conditions checkbox")
        }
        
        
        //        if (self.userEmailTextField.text?.isEmpty) == true
        //        {
        //            showAlert(message: "Please enter email")
        //        }
        //        else if (self.passwordTextField.text?.isEmpty) == true
        //        {
        //            showAlert(message: "Please enter password")
        //        }
        //        else
        //        {
        //            if isCheckBoxSelected == true
        //            {
        //                if internetConnection.isConnectedToNetwork() == true {
        //                    self.logInApi()
        //                }else{
        //                    self.showAlert(message: "Please check your internet", title: "Network issue")
        //                }
        //            }
        //            else
        //            {
        //                showAlert(message: "Please select terms and conditions checkbox")
        //            }
        //        }
        
    }
    
    private func logInApi(){
        
        let email = (userEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        let password = (passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        
        let request = BatchLoginRequest(email: email, password: password, deviceToken: "ABCDE")
        
        DispatchQueue.main.async {
            showLoading()
        }
        
        let bLogInViewModel = BLogInViewModel()
        let urlStr = API.logIn
        bLogInViewModel.loginApi(request: request) { (response) in
            
            if response.status == true,response.token != nil {
                print(response.data)
                // self.blogsArray = response.data!
                
                
                DispatchQueue.main.async {
                    hideLoading()
                    
                    //                    UserDefaultUtility.saveToken(token: response.token ?? "")
                    Batch_UserDefaults.set(response.token ?? "" , forKey: UserDefaultKey.TOKEN)
                    let getToken = Batch_UserDefaults.value(forKey: UserDefaultKey.TOKEN)
                    UserDefaultUtility.setUserLoggedIn(true)
                    Batch_UserDefaults.setValue(response.data?.profile_photo_path, forKey:UserDefaultKey.profilePhoto )
                    if self.isCommingFrom == "workoutbatches" {
                        let vc = BCheckoutVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .coverVertical
                        vc.promotionPriceValue = 0
                        vc.selectedSubscriptionInfo = [self.selectedSubscriptionInfo[0]]
                        vc.isCommingFrom = self.isCommingFrom
                        self.present(vc, animated: true)
                    }else if self.isCommingFrom == "MealBatchSubscribe" {
                        let vc = MealPlanCheckout.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
                        vc.isCommingFrom = "MealBatchSubscribe"
                        vc.mealData = self.mealData
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .coverVertical
                        self.present(vc, animated: true)
                    }else{
                        self.dismiss(animated: true)
                    }
                    
                    
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.showAlert(message: response.message ?? "")
                    //makeToast(response.message!)
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: "\(error.localizedDescription)")
                // makeToast(error.localizedDescription)
            }
        }
    }
    
    @IBAction func onTapSignUpBtn(_ sender: Any) {
        let vc = BRegistrationVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.promotionPriceValue = 0
        if isCommingFrom == "workoutbatches" {
            vc.selectedSubscriptionInfo = [selectedSubscriptionInfo[0]]
        }
        if self.isCommingFrom == "MealBatchSubscribe" {
            vc.mealData = mealData
        }
//        else if self.isCommingFrom == "MotivatorDetailVC" {
//            vc.selectedSubscriptionInfo = [selectedSubscriptionInfo[0]]
//        }
        vc.isCommingFrom = isCommingFrom
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
        
    @IBAction func onTapBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func appleLoginAction(_ sender: UIButton) {
        //handleAuthorizationAppleIDButtonPress()
    }
    
    
    //  MARK:-  Apple Login Delegate func
    
    func handleAuthorizationAppleIDButtonPress() {
        
        if #available(iOS 13.2, *)  {
            // Create the authorization request
            let request = ASAuthorizationAppleIDProvider().createRequest()
            
            // Set Scopes
            request.requestedScopes = [.email, .fullName]
            
            // Setup a controller to display the authorization flow
            let controller = ASAuthorizationController(authorizationRequests: [request])
            
            // Set delegate to handle the flow response.
            controller.delegate = self
            controller.presentationContextProvider = self
            
            
            // Action
            controller.performRequests()
            
        }
        
        else {
            
            print("ios12")
        }
        
    } // END
    
    
    
    //    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    //        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
    //            let userIdentifier = appleIDCredential.user
    //            let fullName = appleIDCredential.fullName
    //            let email = appleIDCredential.email
    //            print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))")
    //
    //        }
    //    }
    
    
    @IBAction func googleSignInBtn(_ sender: Any) {
        //        GIDSignIn.sharedInstance.signIn(withPresenting: self)
        googleSignIn()
        
    }
    
    func googleSignIn(){
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            
            let emailAddress = user.profile?.email
            
            let fullName = user.profile?.name
            let givenName = user.profile?.givenName
            let familyName = user.profile?.familyName
            
            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            
            //            if error != nil {
            //                // If sign in succeeded, display the app's main content View.
            //                guard let signInResult = signInResult else { return }
            //
            //                let user = signInResult.user
            //
            //                let emailAddress = user.profile?.email
            //                let fullName = user.profile?.name
            //                let familyName = user.profile?.familyName
            //                let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            //
            //            }
            //            else{
            //                self.showAlert(message: error?.localizedDescription ?? "")
            //            }
        }
    }
    
}




@available(iOS 13.0, *)

extension BLogInVC: ASAuthorizationControllerDelegate {
    
    // ASAuthorizationControllerDelegate function for authorization failed
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // ASAuthorizationControllerDelegate function for successful authorization
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if #available(iOS 12.0, *) {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                // Create an account as per your requirement
                let appleId = appleIDCredential.user
                let appleUserFirstName = appleIDCredential.fullName?.givenName
                let appleUserLastName = appleIDCredential.fullName?.familyName
                let appleUserEmail = appleIDCredential.email
                
                
                //                self.userSocialType = "Apple_id"
                //                self.userSocialID = appleId
                //                self.userName = appleUserFirstName!
                //                //  self.last_name = appleUserLastName!
                //                self.userEmail = appleUserEmail!
                //
                //                social_logonApi()
                //Write your code
            } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
                let appleUsername = passwordCredential.user
                let applePassword = passwordCredential.password
                //Write your code
            }
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 13.2, *)  {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                // Create an account as per your requirement
                let appleId = appleIDCredential.user
                let appleUserFirstName = appleIDCredential.fullName?.givenName
                let appleUserLastName = appleIDCredential.fullName?.familyName
                let appleUserEmail = appleIDCredential.email
                
                
                
                //                self.userSocialType = "Apple_id"
                //                self.userSocialID = appleId
                //                self.userName = appleUserFirstName!
                //                //  self.last_name = appleUserLastName!
                //                self.userEmail = appleUserEmail!
                //
                //                social_logonApi()
                
            } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
                let appleUsername = passwordCredential.user
                let applePassword = passwordCredential.password
                //Write your code
            }
        } else {
            
        }
        
    } // END apple btn delegates func
    
    
}

@available(iOS 13.0, *)
extension BLogInVC: ASAuthorizationControllerPresentationContextProviding {
    //For present window
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
        
    } // END
}




