//
//  WelcomeVC.swift
//  Batch
//
//  Created by Chawtech on 03/02/24.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet private weak var circleOnSceneView: CircularProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        circleOnSceneView.setProgressColor = UIColor(displayP3Red: 50.0/255.0, green: 168.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        //        circleOnSceneView.setTrackColor = UIColor(displayP3Red: 205.0/255.0, green: 247.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        
        circleOnSceneView.setProgressColor = Colors.appThemeButtonColor
        circleOnSceneView.setTrackColor = Colors.appBorderLightColor
        
        circleOnSceneView.setProgressWithAnimation(duration: 2.0, value: 0.25)
        
        showActivityIndicator()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
        {
            self.circleOnSceneView.setProgressWithAnimation(duration: 2.0, value: 1.0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                print("Task 2 completed after a delay")
                self.hideActivityIndicator()
                //self.dismiss(animated: false)
                
                let vc = ShowTotalBurnerCaloryVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                self.present(vc, animated: true)
                
                
            }
        }
        
        
    }
    
    
    
    
}
