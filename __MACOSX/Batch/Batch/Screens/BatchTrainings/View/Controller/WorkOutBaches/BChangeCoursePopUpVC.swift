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
        self.dismiss(animated: true)
    }
    @IBAction func onTapCancelBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
