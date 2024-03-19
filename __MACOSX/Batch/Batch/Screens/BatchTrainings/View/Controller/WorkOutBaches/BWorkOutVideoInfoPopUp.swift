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
    @IBOutlet var setRepsTimeTitleLbl: UILabel!
    @IBOutlet var setRepsTimeDataLbl: UILabel!
    var dayNumberText : String!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
       
        dayLbl.text = dayNumberText
        videoTitleLbl.text = courseDurationExercise.title
        videoDescriptionLbl.text = courseDurationExercise.description
        videoInstructionLbl.text = courseDurationExercise.instruction
        
        setUpTimeValue()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    @IBAction func dismissNotificationView(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    func setUpTimeValue() {
        var timeTextTitle = ""
        var timeText = ""
        if self.courseDurationExercise.exerciseSet != nil {
            timeTextTitle = "Set/"
            timeText = "\(self.courseDurationExercise.exerciseSet ?? "")/"
        }
        
        if self.courseDurationExercise.exerciseWraps != nil {
            timeTextTitle = timeTextTitle + "Reps/"
            timeText = timeText + "\(self.courseDurationExercise.exerciseWraps ?? "")/"
        }
        
        if self.courseDurationExercise.exerciseTime != nil {
            timeTextTitle = timeTextTitle + "Time/"
            timeText = timeText + "\(self.courseDurationExercise.exerciseTime ?? "")/"
        }
        
        setRepsTimeTitleLbl.text = String(timeTextTitle.dropLast())
        setRepsTimeDataLbl.text =  String(timeText.dropLast())
    }
    
}
