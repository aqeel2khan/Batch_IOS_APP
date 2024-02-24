//
//  BUserGenderVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 19/12/23.
//

import UIKit

class BUserGenderVC: UIViewController {
    
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblAlreadyHaveAccount: UILabel!
    @IBOutlet weak var btnContinue: BatchButton!
    @IBOutlet weak var lblFemale: UILabel!
    @IBOutlet weak var lblMale: UILabel!
    
    @IBOutlet weak var maleIconTextBackView: UIView!
    @IBOutlet weak var femaleIconTextBackView: UIView!
    
    
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
    
    @IBAction func onTapGenderBtn(_ sender: UIButton) {
        /*
        sender.isSelected = !sender.isSelected
      
         switch sender.tag {
         case 201:
         sender.isSelected == true ? (self.maleIconTextBackView.backgroundColor = Colors.appThemeSelectionColor) : (self.femaleIconTextBackView.backgroundColor = Colors.appViewBackgroundColor)
         case 202:
         sender.isSelected == true ? (self.femaleIconTextBackView.backgroundColor = Colors.appThemeSelectionColor) : (self.maleIconTextBackView.backgroundColor = Colors.appViewBackgroundColor)
         default:
         print("Have you done something new?")
         }
         */
        
        /*
         switch sender.tag {
         case 201:
         sender.isSelected = !sender.isSelected
         
         sender.isSelected == true ? (self.maleIconTextBackView.backgroundColor = Colors.appThemeSelectionColor) : (self.maleIconTextBackView.backgroundColor = Colors.appViewBackgroundColor)
         
         case 202:
         sender.isSelected = !sender.isSelected
         sender.isSelected == true ? (self.femaleIconTextBackView.backgroundColor = Colors.appThemeSelectionColor) : (self.femaleIconTextBackView.backgroundColor = Colors.appViewBackgroundColor)
         
         default:
         print("Have you done something new?")
         }
         */
    }
    
    @IBAction func onTapSignInBtn(_ sender: Any) {
        
        let tabbarVC = UIStoryboard(name: "BatchTabBar", bundle: nil).instantiateViewController(withIdentifier: "BatchTabBarNavigation")
        tabbarVC.modalPresentationStyle = .fullScreen
        present(tabbarVC, animated: true, completion: nil)
        
        /*
         let vc = BWorkOutVC.instantiate(fromAppStoryboard: .batchTrainings)
         vc.modalPresentationStyle = .overFullScreen
         vc.modalTransitionStyle = .crossDissolve
         self.present(vc, animated: true)
         */
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
