//
//  BUserFollowingVC.swift
//  Batch
//
//  Created by Hari Mohan on 19/02/24.
//

import Foundation
import UIKit
import SDWebImage

class BUserLogoutVC: UIViewController {
    @IBOutlet var mainView: UIView!
    
    var callBackToProfile:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }  
    
    //MARK: Button Action Btn
    
    @IBAction func onTapYesBtn(_ sender: UIButton) {
        self.logoutUser()
    }
    @IBAction func onTapCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    func logoutUser(){
        if internetConnection.isConnectedToNetwork(){
        let bLogoutVM = BUserLogoutVM()
        DispatchQueue.main.async {
            showLoading()
        }
        bLogoutVM.logout{ response in
            DispatchQueue.main.async {
                hideLoading()
                self.dismiss(animated: true) {
                    Batch_UserDefaults.removeObject(forKey: USER_DEFAULTS_KEYS.USER_NAME)
                    Batch_UserDefaults.removeObject(forKey: UserDefaultKey.TOKEN)
                    Batch_UserDefaults.setValue(nil, forKey: UserDefaultKey.profilePhoto)
                    Batch_UserDefaults.setValue(false, forKey: UserDefaultKey.healthPermission)
                    Batch_UserDefaults.setValue(nil, forKey:UserDefaultKey.profilePhotoPath)
                    UserDefaultUtility.setUserLoggedIn(false)
                    SDImageCache.shared.clearMemory()
                    SDImageCache.shared.clearDisk()
                    self.callBackToProfile?()
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
