//
//  ShowTotalBurnerCaloryVC.swift
//  Batch
//
//  Created by Chawtech on 02/02/24.
//

import UIKit

class ShowTotalBurnerCaloryVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backActinBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func nextActionBtn(_ sender: UIButton) {
        self.switchToHomeVC()
    }
    func switchToHomeVC() {
            let vc = BatchTabBarController.instantiate(fromAppStoryboard: .batchTabBar)
            tabBarController?.selectedIndex = 1
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else {
                Batch_AppDelegate.window?.rootViewController = vc
            }
        }
}
