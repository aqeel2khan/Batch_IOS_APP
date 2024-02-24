//
//  BUserGenderVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 19/12/23.
//

import UIKit

class BUserProfileVC: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setUpLocalization()
        
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
        let vc = BUserProfileVC.instantiate(fromAppStoryboard: .batchAccount)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
}
