//
//  MealPlanAddressVC.swift
//  Batch
//
//  Created by Chawtech on 27/01/24.
//

import UIKit

class MealPlanAddressVC: UIViewController {

    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
         mainView.addGestureRecognizer(tap)
     }
     
     @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
      //   self.dismiss(animated: true)
     }
    
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func btnApplyAction(_ sender: UIButton) {
        
        let vc = BWOPlanDurationPopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.isCommingFrom = "MealPlanAddressVC"
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
}
