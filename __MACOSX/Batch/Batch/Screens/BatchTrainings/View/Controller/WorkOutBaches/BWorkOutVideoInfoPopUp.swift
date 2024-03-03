//
//  BWorkOutAllowNotificationVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import UIKit

class BWorkOutVideoInfoPopUp: UIViewController {
    var courseDurationExercise:CourseDurationExercise!

    @IBOutlet var mainView: UIView!
    @IBOutlet var dayLbl: UILabel!
    @IBOutlet var descriptionDetailLbl: UILabel!
    @IBOutlet var instructionDetailLbl: UILabel!
    var dayNumberText : String!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
       
        dayLbl.text = dayNumberText
        descriptionDetailLbl.text = courseDurationExercise.description
        instructionDetailLbl.text = courseDurationExercise.instruction
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    @IBAction func dismissNotificationView(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
