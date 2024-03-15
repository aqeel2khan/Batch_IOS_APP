
import UIKit
import GoogleSignIn
import AuthenticationServices

class BLogInVC: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnFbLogin: BatchButton!
    @IBOutlet weak var btnAppleLogin: BatchButton!
    @IBOutlet weak var btnGoogleLogin: BatchButton!
    @IBOutlet weak var btnOutlookLogin: BatchButton!

    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
  
    var promotionPriceValue = 0.0
    var selectedSubscriptionInfo = [CourseDataList]()
    
    var isCommingFrom = ""
    var mealData : Meals!
    
    var CallBackToUpdateProfile:(()->())?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onTapPassowrdEyeBtn(_ sender: UIButton) {
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
        if internetConnection.isConnectedToNetwork() == true {
            self.logInApi()
        } else{
            self.showAlert(message: "Please check your internet", title: "Network issue")
        }
    }
    
    private func logInApi(){
        let email = (userEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        let password = (passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
        
        let request = BatchLoginRequest(email: email, password: password, deviceToken: "ABCDE")
        
        DispatchQueue.main.async {
            showLoading()
        }
        
        let bLogInViewModel = BLogInViewModel()
        bLogInViewModel.loginApi(request: request) { (response) in
            if response.status == true,response.token != nil {
                DispatchQueue.main.async {
                    hideLoading()
                    Batch_UserDefaults.set(response.data?.id, forKey: UserDefaultKey.USER_ID)
                    Batch_UserDefaults.set(response.token ?? "" , forKey: UserDefaultKey.TOKEN)
                    UserDefaultUtility.setUserLoggedIn(true)
                    self.getProfileData(profile: response.data?.profile_photo_path ?? "")
                    Batch_UserDefaults.setValue(response.data?.profile_photo_path, forKey:UserDefaultKey.profilePhoto )
                    UserDefaultUtility.saveUserId(userId: response.data?.id ?? 0)
                
                    if self.isCommingFrom == "workoutbatches" {
                        let vc = BCheckoutVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .coverVertical
                        vc.promotionPriceValue = 0
                        vc.selectedSubscriptionInfo = [self.selectedSubscriptionInfo[0]]
                        vc.isCommingFrom = self.isCommingFrom
                        self.present(vc, animated: true)
                    } else if self.isCommingFrom == "MealBatchSubscribe" {
                        let vc = MealPlanCheckout.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
                        vc.isCommingFrom = "MealBatchSubscribe"
                        vc.mealData = self.mealData
                        vc.modalPresentationStyle = .overFullScreen
                        vc.modalTransitionStyle = .coverVertical
                        self.present(vc, animated: true)
                    } else if self.isCommingFrom == "OnBoarding" {
                        UserDefaults.standard.set("Kuwait", forKey: USER_DEFAULTS_KEYS.SELECTED_COUNTRY)
                        UserDefaults.standard.synchronize()
                        
                        let tabbarVC = UIStoryboard(name: "BatchTabBar", bundle: nil).instantiateViewController(withIdentifier: "BatchTabBarNavigation")
                        tabbarVC.modalPresentationStyle = .fullScreen
                        self.present(tabbarVC, animated: true, completion: nil)
                    } else {
                        self.dismiss(animated: true)
                    }
                        self.CallBackToUpdateProfile?()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.CallBackToUpdateProfile?()
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
    
    func getProfileData(profile:String){
        let url = URL(string: BaseUrl.imageBaseUrl + profile)!
        let dataTask = URLSession.shared.dataTask(with: url){ data,repo,err in
            if err == nil{
                Batch_UserDefaults.setValue(data ?? Data(), forKey: UserDefaultKey.profilePhoto)
            }
        }
        dataTask.resume()
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




