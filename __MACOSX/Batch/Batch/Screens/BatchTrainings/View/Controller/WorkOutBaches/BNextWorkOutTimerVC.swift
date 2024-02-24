//
//  BNextWorkOutTimerVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/01/24.
//

import UIKit

class BNextWorkOutTimerVC: UIViewController {
    
    var datePicker1: UIDatePicker!

    @IBOutlet weak var datePIckerView: UIDatePicker!
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var tuedayView: UIView!
    @IBOutlet weak var wednsdayView: UIView!
    @IBOutlet weak var thrdayView: UIView!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var satdayView: UIView!
    @IBOutlet weak var sundayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
   
    
    func setUpView() {
        mondayView.cornerRadius = 8
        tuedayView.cornerRadius = 8
        wednsdayView.cornerRadius = 8
        thrdayView.cornerRadius = 8
        fridayView.cornerRadius = 8
        satdayView.cornerRadius = 8
        sundayView.cornerRadius = 8
    }
    
    @IBAction func onTapNextBtn(_ sender: UIButton) {
        
        let vc = BWorkOutAllowNotificationVC.instantiate(fromAppStoryboard: .batchTrainings)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
}
