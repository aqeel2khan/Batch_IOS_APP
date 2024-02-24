//
//  MealDilevaryDropOffVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 30/01/24.
//

import UIKit

class MealDilevaryDropOffVC: UIViewController {
    
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func backactionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnApplyAction(_ sender: UIButton) {
        
        let vc = BThankyouPurchaseVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.isCommingFrom = "MealPlanCheckout"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true )
    }


}
