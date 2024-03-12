//
//  BWorkOutAllowNotificationVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import UIKit

class BWorkOutVideoInfoPopUp: UIViewController {
    var courseDurationExercise:CourseDurationExercise!
    var courseDetail: CourseDetail!
    var todayWorkoutsInfo : TodayWorkoutsElement!

    @IBOutlet var mainView: UIView!
    @IBOutlet var dayLbl: UILabel!
    @IBOutlet var videoTitleLbl: UILabel!
    @IBOutlet var videoDescriptionLbl: UILabel!
    @IBOutlet var videoInstructionLbl: UILabel!
    var dayNumberText : String!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
       
        dayLbl.text = dayNumberText
        videoTitleLbl.text = courseDurationExercise.title
        videoDescriptionLbl.text = courseDurationExercise.description
        videoInstructionLbl.text = courseDurationExercise.instruction
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    @IBAction func dismissNotificationView(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
