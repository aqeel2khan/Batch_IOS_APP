//
//  BUserGenderVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 19/12/23.
//

import UIKit

class BUserPersonalInfoVC: UIViewController {
    @IBOutlet var mainView: UIView!

    @IBOutlet weak var femaleBtnTapped: UIButton!
    @IBOutlet weak var maleBtnTapped: UIButton!
    @IBOutlet weak var saveBtn: BatchButton!
    @IBOutlet weak var dobTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phnTxt: UITextField!
    @IBOutlet weak var fNameTxt: UITextField!
    
    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        getUserPersonalInfo()
    }

    func showDatePicker(){
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = sender?.date {
            
            dobTxt.text = dateFormatter.string(from: date)
            saveBtn.setTitle("Save", for: .normal)
        }
    }

    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    func getUserPersonalInfo(){
        
        if internetConnection.isConnectedToNetwork(){
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
        }else{
            self.showAlert(message: "Please check your internet", title: "Network issue")
        }
    }
    
    func updateUI(response: GetProfileResponse){
        if response.data?.gender ?? "" == "Male"{
            maleBtnTapped.isSelected = true
            femaleBtnTapped.isSelected = false
        }else if response.data?.gender ?? "" == "Female"{
            maleBtnTapped.isSelected = false
            femaleBtnTapped.isSelected = true
        }else{
            maleBtnTapped.isSelected = true
            femaleBtnTapped.isSelected = false
        }
        fNameTxt.text = response.data?.name ?? ""
        phnTxt.text = response.data?.phone ?? ""
        dobTxt.text = response.data?.dob ?? ""
        emailTxt.text = response.data?.email ?? ""
        fNameTxt.delegate = self
        phnTxt.delegate = self
        dobTxt.delegate = self
        emailTxt.delegate = self
        saveBtn.setTitle("Edit".localized, for: .normal)
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
    
    @IBAction func genderBtnTapped(_ sender: UIButton) {
        switch sender.tag{
        case 0:
            maleBtnTapped.isSelected = true
            femaleBtnTapped.isSelected = false
        case 1:
            maleBtnTapped.isSelected = false
            femaleBtnTapped.isSelected = true
        default:
            break
        }
        saveBtn.setTitle("Save", for: .normal)
    }
    @IBAction func dobBtnTapped(_ sender: UIButton) {
        showDatePicker()
    }
    
    @IBAction func onTapBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapSaveBtn(_ sender: UIButton) {
        if ((sender.titleLabel?.text ?? "") == "Save"){
            self.view.endEditing(true)
            self.updateUserPersonalInfo()
        }
    }
    
    @IBAction func outsideViewTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    func updateUserPersonalInfo(){
        if internetConnection.isConnectedToNetwork(){
            let request: UpdateProfileRequest
            if maleBtnTapped.isSelected{
                request = UpdateProfileRequest(mobile: phnTxt.text ?? "", name: fNameTxt.text ?? "", dob: dobTxt.text ?? "", gender: "Male")
            }else{
                request = UpdateProfileRequest(mobile: phnTxt.text ?? "", name: fNameTxt.text ?? "", dob: dobTxt.text ?? "", gender: "Female")
            }
        let bUserPersonalInfoVM = BUserPersonalInfoVM()
        DispatchQueue.main.async {
            showLoading()
        }
        bUserPersonalInfoVM.updatePersonalInfo(request: request) { response in
            DispatchQueue.main.async {
                hideLoading()
                self.saveBtn.setTitle("Edit".localized, for: .normal)
                self.showAlertViewWithOne(title: "Batch", message: response.message ?? "", option1: "Ok") {
                    self.dismiss(animated: true)
                }
            }
            
        } onError: { error in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: error.localizedDescription)
            }
        }
    }else{
        self.showAlert(message: "Please check your internet", title: "Network issue")
    }
    }
    
}
