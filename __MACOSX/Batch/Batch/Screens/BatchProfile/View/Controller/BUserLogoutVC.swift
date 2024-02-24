//
//  BUserFollowingVC.swift
//  Batch
//
//  Created by Hari Mohan on 19/02/24.
//

import Foundation
import UIKit

class BUserLogoutVC: UIViewController {
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
    
    @IBAction func onTapYesBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    @IBAction func onTapCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
