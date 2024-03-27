//
//  BUserGenderVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 19/12/23.
//

import UIKit
import SDWebImage

class BUserProfileVC: UIViewController {
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var callBackToUpdateNavigation: (()->())?
    var MediaPlaye:Media? = nil
    let dGroup = DispatchGroup()
    let operationQueue = OperationQueue()
    let que = DispatchQueue(label: "so")
    var mobileStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProfileData()
        imagePicker.delegate = self
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
    
    func getProfileData(){
        DispatchQueue.main.async {
            showLoading()
        }
        let bUserProfileVM = BUserProfileVM()
        bUserProfileVM.getProfileDetails { response in
            DispatchQueue.main.async {
                hideLoading()
                self.updateUI(response: response)
            }
            
        } onError: { error in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
    func updateUI(response: GetProfileResponse){
            self.userImageView.sd_setImage(with:  URL(string: BaseUrl.imageBaseUrl + (response.data?.profile_photo_path ?? ""))!, placeholderImage: UIImage(named: "Avatar"))
            UserDefaults.standard.set(response.data?.name ?? "", forKey: USER_DEFAULTS_KEYS.USER_NAME)
            userNameLbl.text = response.data?.name ?? ""
        mobileStr = response.data?.phone ?? ""
    }
    
    @IBAction func uploadPhotoBtnTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo".localized, style: .default, handler: { _ in
                self.openCamera()
            }))
            
        alert.addAction(UIAlertAction(title: "Choose Photo".localized, style: .default, handler: { _ in
                self.openGallary()
            }))
            
        alert.addAction(UIAlertAction.init(title: "Cancel".localized, style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapPersonalInfoBtn(_ sender: UIButton) {
        let vc = BUserPersonalInfoVC.instantiate(fromAppStoryboard: .batchAccount)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapChangeLanguageBtn(_ sender: UIButton) {
        let vc = BatchCountryLanguageVC.instantiate(fromAppStoryboard: .main)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapFollowingBtn(_ sender: UIButton) {
        let vc = BUserFollowingVC.instantiate(fromAppStoryboard: .batchAccount)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapDeliveryDetailsBtn(_ sender: UIButton) {
        let vc = BUserDeliveryDetailVC.instantiate(fromAppStoryboard: .batchAccount)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapNotificationBtn(_ sender: UIButton) {
        let vc = BUserNotificationVC.instantiate(fromAppStoryboard: .batchAccount)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapDeleteAccountBtn(_ sender: UIButton) {
        let vc = BUserDeleteAccountVC.instantiate(fromAppStoryboard: .batchAccount)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.mobileStr = mobileStr
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapLogoutBtn(_ sender: UIButton) {
        let vc = BUserLogoutVC.instantiate(fromAppStoryboard: .batchAccount)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.callBackToProfile = {
            self.dismiss(animated: true){
                self.callBackToUpdateNavigation?()
            }
        }
        self.present(vc, animated: true)
    }
}

extension BUserProfileVC : barButtonTappedDelegate {
    func rightThirdBarBtnItem() {
        if (UserDefaultUtility.isUserLoggedIn()) {
            let vc = BUserProfileVC.instantiate(fromAppStoryboard: .batchAccount)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }else{
            self.showAlert(message: "First login then you are able to check profile details.")
        }
    }
}

extension BUserProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    /// Open the camera
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    /// Choose image from camera roll
    func openGallary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        // If you don't want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
   
    // MARK:-- Camera Methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) { [self] in
            if let image = info[.originalImage] as? UIImage {
                DispatchQueue.main.async {
                    self.userImageView.image = image
                    self.userImageView.contentMode = .scaleAspectFit
                    self.userImageView.clipsToBounds = true
                }
                self.MediaPlaye = nil
                let mediafile = Media(withImage: image, forKey: "profile_image")
                self.MediaPlaye = mediafile
                self.profileUploadAndUpdate()
               
            }
        }
    }
    
    func profileUploadAndUpdate(){
        var profile = ""
        
        let profileUploadBlockOperation = BlockOperation()
        profileUploadBlockOperation.addExecutionBlock {
            DispatchQueue.main.async {
                showLoading()
            }
            if internetConnection.isConnectedToNetwork() == true {
                self.dGroup.enter()
                let bUserProfileVM = BUserProfileVM()
                if let media = self.MediaPlaye {
                    bUserProfileVM.uploadProfilePhoto(media: media) { response in
                        profile = response.data?.profile_photo_path ?? ""
                        self.dGroup.leave()
                    } onError: { error in
                        DispatchQueue.main.async {
                            self.showAlert(message: error.localizedDescription)
                            self.dGroup.leave()
                        }
                    }
                }
                self.dGroup.wait()
            }else{
                self.showAlert(message: "Please check your internet", title: "Network issue")
            }
        }
        let profileUpdateBlockOperation = BlockOperation()
        profileUpdateBlockOperation.addExecutionBlock {
            let url = URL(string: BaseUrl.imageBaseUrl + profile)!
            let dataTask = URLSession.shared.dataTask(with: url){ data,repo,err in
                
                if err == nil{
                    Batch_UserDefaults.setValue(data ?? Data(), forKey: UserDefaultKey.profilePhoto)
                    let getprofilePhoto = Batch_UserDefaults.value(forKey: UserDefaultKey.profilePhoto) as? Data
                    DispatchQueue.main.async {
                            hideLoading()
                        if getprofilePhoto != nil{
                            self.userImageView.contentMode = .scaleAspectFill
                            self.userImageView.clipsToBounds = true
                            self.userImageView.image = UIImage(data: getprofilePhoto ?? Data())
                        }else{
                            self.userImageView.contentMode = .scaleAspectFill
                            self.userImageView.clipsToBounds = true
                            self.userImageView.image = UIImage(named: "Avatar")
                        }
                    }
                }else{
                    self.userImageView.contentMode = .scaleAspectFit
                    self.userImageView.clipsToBounds = true
                    self.userImageView.image = UIImage(named: "Avatar")
                }
            }
            dataTask.resume()
        }
        
        profileUpdateBlockOperation.addDependency(profileUploadBlockOperation)
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(profileUploadBlockOperation)
        operationQueue.addOperation(profileUpdateBlockOperation)
    }
}
