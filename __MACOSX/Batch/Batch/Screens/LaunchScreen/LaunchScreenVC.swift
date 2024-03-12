//
//  LaunchScreenVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/02/24.
//

import UIKit

class LaunchScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if  !UserDefaultUtility.isUserLoggedIn() {
            DispatchQueue.main.async {
                let vc = OnBoardingScreenVC.instantiate(fromAppStoryboard: .main)
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
        else {
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    let tabbarVC = UIStoryboard(name: "BatchTabBar", bundle: nil).instantiateViewController(withIdentifier: "BatchTabBarNavigation")
                    tabbarVC.modalPresentationStyle = .fullScreen
                    self.present(tabbarVC, animated: true, completion: nil)
                }
            }
        }
    }
}
