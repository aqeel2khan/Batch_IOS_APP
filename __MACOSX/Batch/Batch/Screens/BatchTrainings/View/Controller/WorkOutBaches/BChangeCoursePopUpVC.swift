//
//  BChangeCoursePopUpVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 18/01/24.
//

import UIKit

class BChangeCoursePopUpVC: UIViewController {
    
    @IBOutlet var mainView: UIView!
    
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
    
    @IBAction func onTapCourseSelectionBtn(_ sender: UIButton) {
        //self.dismiss(animated: true)
        
        self.switchToDashBoardVC()
        
    }
    
    @IBAction func onTapCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    func switchToDashBoardVC() {
            
            let vc = BatchTabBarController.instantiate(fromAppStoryboard: .batchTabBar)
            tabBarController?.selectedIndex = 4
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else {
                Batch_AppDelegate.window?.rootViewController = vc
            }
        }
}
