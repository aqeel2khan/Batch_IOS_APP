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
        
        circleOnSceneView.setProgressColor = Colors.appThemeButtonColor
        circleOnSceneView.setTrackColor = Colors.appBorderLightColor
        
        circleOnSceneView.setProgressWithAnimation(duration: 2.0, value: 0.25)
        
        showActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.circleOnSceneView.setProgressWithAnimation(duration: 2.0, value: 1.0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                print("Task 2 completed after a delay")
                self.hideActivityIndicator()
                
                let vc = ShowTotalBurnerCaloryVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                self.present(vc, animated: true)
            }
        }
    }
}
