//
//  BWorkOutCompleteVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 21/01/24.
//

import UIKit

class BWorkOutCompleteVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
   
    
    
    override func viewDidLoad() {
        scrollView.makeSpecificCornerRound(corners: .topTwo, radius: 30)
        
    }
    
    @IBAction func onTapContinueBtn(_ sender: UIButton) {
        
       // tabBarController?.selectedIndex = 1
       // /*
         let vc = BNextWorkOutTimerVC.instantiate(fromAppStoryboard: .batchTrainings)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
       //  */
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
