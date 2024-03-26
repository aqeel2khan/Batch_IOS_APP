//
//  BRegistrationVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 30/01/24.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

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

    }
    
    @IBAction func onTapTermsAndConditionBtn(_ sender: UIButton) {
        let vc = BPrivacyVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapWithGoogleSignUpBtn(_ sender: UIButton) {
        self.googleLogin()
    }
   
    @IBAction func onTapWithAppleSignUpBtn(_ sender: UIButton) {
        handleAuthorizationAppleIDButtonPress()
    }
    
    
    @IBAction func onTapCheckBoxBtn(_ sender: UIButton) {
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
        let fcm_token : String = UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.FCM_KEY) as? String ?? ""

        let request = BRegistrationRequest(email: "\(email)", password: "\(password)", mobile: "\(mobile)", name: "\(name)", device_token: "\(fcm_token)")
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
                    else if self.isCommingFrom == "MealBatchSubscribe" {
                        let vc = MealPlanCheckout.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
                        vc.isCommingFrom = "MealBatchSubscribe"
                        vc.mealData = self.mealData
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .coverVertical
                        self.present(vc, animated: true)
                    } else {
                        let tabbarVC = UIStoryboard(name: "BatchTabBar", bundle: nil).instantiateViewController(withIdentifier: "BatchTabBarNavigation")
                        tabbarVC.modalPresentationStyle = .fullScreen
                        self.present(tabbarVC, animated: true, completion: nil)
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

extension BRegistrationVC {
    func googleLogin() {
        let config = GIDConfiguration(clientID: GOOGLE_CLIENT_ID)
        GIDSignIn.sharedInstance.configuration = config
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
            
            self.showAlert(message: "You have successfully login : Hi, \((fullName) ?? "") \n \((user.accessToken.tokenString))")
        }
        
    }
}

extension BRegistrationVC: ASAuthorizationControllerDelegate {
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
    }
    
    // ASAuthorizationControllerDelegate function for authorization failed
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // ASAuthorizationControllerDelegate function for successful authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Create an account as per your requirement
            let appleId = appleIDCredential.user
            let appleUserFirstName = appleIDCredential.fullName?.givenName ?? ""
            let appleUserLastName = appleIDCredential.fullName?.familyName ?? ""
            let appleUserEmail = appleIDCredential.email ?? ""
            //                self.userSocialType = "Apple_id"
            //                self.userSocialID = appleId
            //                self.userName = appleUserFirstName!
            //                //  self.last_name = appleUserLastName!
            //                self.userEmail = appleUserEmail!
            //
            //                social_logonApi()
            
            self.showAlert(message: "You have successfully login : Hi, \(appleUserFirstName) \(appleUserLastName) \n \(appleUserEmail)")
            
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let appleUsername = passwordCredential.user
            let applePassword = passwordCredential.password
            
            self.showAlert(message: "You have successfully login : Hi, \(appleUsername)  \n \(applePassword)")
        }
    }
}

@available(iOS 13.0, *)
extension BRegistrationVC: ASAuthorizationControllerPresentationContextProviding {
    //For present window
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    } // END
}
