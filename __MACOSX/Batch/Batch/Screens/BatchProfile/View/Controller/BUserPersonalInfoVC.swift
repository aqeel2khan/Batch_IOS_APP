//
//  BUserGenderVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 19/12/23.
//

import UIKit

class BUserPersonalInfoVC: UIViewController {
    @IBOutlet var mainView: UIView!

    @IBOutlet weak var saveBtn: BatchButton!
    @IBOutlet weak var genderTxt: UITextField!
    @IBOutlet weak var dobTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phnTxt: UITextField!
    @IBOutlet weak var fNameTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
        getUserPersonalInfo()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    
    func getUserPersonalInfo(){
        let bUserPersonalInfoVM = BUserPersonalInfoVM()
        DispatchQueue.main.async {
            showLoading()
        }
        bUserPersonalInfoVM.getProfileDetails { response in
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
        genderTxt.text = response.data?.gender ?? ""
        fNameTxt.text = response.data?.name ?? ""
        phnTxt.text = response.data?.phone ?? ""
        dobTxt.text = response.data?.dob ?? ""
        emailTxt.text = response.data?.email ?? ""
        genderTxt.delegate = self
        fNameTxt.delegate = self
        phnTxt.delegate = self
        dobTxt.delegate = self
        emailTxt.delegate = self
        saveBtn.setTitle("Edit", for: .normal)
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
        if ((sender.titleLabel?.text ?? "") == "Save"){
            self.view.endEditing(true)
            self.updateUserPersonalInfo()
        }
    }
    
    func updateUserPersonalInfo(){
        let request = UpdateProfileRequest(mobile: phnTxt.text ?? "", name: fNameTxt.text ?? "", dob: dobTxt.text ?? "", gender: genderTxt.text ?? "")
        let bUserPersonalInfoVM = BUserPersonalInfoVM()
        DispatchQueue.main.async {
            showLoading()
        }
        bUserPersonalInfoVM.updatePersonalInfo(request: request) { response in
            DispatchQueue.main.async {
                hideLoading()
                self.saveBtn.setTitle("Edit", for: .normal)
                self.showAlert(message: response.message ?? "")
            }
            
        } onError: { error in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: error.localizedDescription)
            }
        }
    }
    
}
