//
//  BThankyouPurchaseVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import UIKit

class BThankyouPurchaseVC: UIViewController {
    
    @IBOutlet weak var descriptionLbl: BatchLabelSubTitleBlack!
    var isCommingFrom = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if isCommingFrom == "MealPlanCheckout"
        {
            self.descriptionLbl.text = "A courier will contact you on the day of delivery."
        }
    }
    
    @IBAction func onTapGoHomeBtn(_ sender: Any) {
        switchToHomeVC()
    }
    
    func switchToHomeVC() {
        
        if isCommingFrom == "MealBatchSubscribe" {
            let vc = BatchTabBarController.instantiate(fromAppStoryboard: .batchTabBar)
            vc.selectedIndex = 4
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else {
                Batch_AppDelegate.window?.rootViewController = vc
            }

        } else {
            let vc = BatchTabBarController.instantiate(fromAppStoryboard: .batchTabBar)
            vc.selectedIndex = 4
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()  
            } else {
                Batch_AppDelegate.window?.rootViewController = vc
            }
        }
    }
}
