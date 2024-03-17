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
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    } 
}
