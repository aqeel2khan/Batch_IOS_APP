//
//  BWorkOutAllowNotificationVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import UIKit

class BWorkOutAllowNotificationVC: UIViewController {

    @IBOutlet var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    @IBAction func dismissNotificationView(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onTapAllowBtn(_ sender: UIButton) {
       // tabBarController?.selectedIndex = 1
        switchToHomeVC()
    }
    
    func switchToHomeVC() {
        
        let vc = BatchTabBarController.instantiate(fromAppStoryboard: .batchTabBar)
        tabBarController?.selectedIndex = 0
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            Batch_AppDelegate.window?.rootViewController = vc
        }
    }
    
}
