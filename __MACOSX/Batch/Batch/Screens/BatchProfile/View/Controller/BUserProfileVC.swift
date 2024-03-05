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
    @IBOutlet weak var lblTitle: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //        setUpLocalization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProfileData()
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
        let bUserProfileVM = BUserProfileVM()
        DispatchQueue.main.async {
            showLoading()
        }
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
        if response.data?.profile_photo_path != nil{
            userImageView.sd_setImage(with: URL(string: BaseUrl.imageBaseUrl + (response.data?.profile_photo_path ?? ""))!, placeholderImage: UIImage(named: "Avatar"))
        }else{
            userImageView.image = UIImage(named: "Avatar")
        }
        userNameLbl.text = response.data?.name ?? ""
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
    
    @IBAction func onTapLogoutBtn(_ sender: UIButton) {
        let vc = BUserLogoutVC.instantiate(fromAppStoryboard: .batchAccount)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
}

extension BUserProfileVC : barButtonTappedDelegate {
    func rightThirdBarBtnItem() {
        let getToken = Batch_UserDefaults.value(forKey: UserDefaultKey.TOKEN)
        if (getToken != nil) && (((getToken as? String) ?? "") != "") {
            let vc = BUserProfileVC.instantiate(fromAppStoryboard: .batchAccount)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }else{
            self.showAlert(message: "First login then you are able to check profile details.")
        }
    }
}
