//
//  BPromoCodeSucessfulPopUpVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 21/01/24.
//

import UIKit

class BPromoCodeSucessfulPopUpVC: UIViewController {
    
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
    @IBAction func onTapOkBtn(_ sender: Any) {
        self.dismiss(animated: true)
            // self.popToVC(<#T##vc: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
}
