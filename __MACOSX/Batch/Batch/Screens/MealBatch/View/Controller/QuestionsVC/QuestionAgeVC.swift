//
//  QuestionAgeVC.swift
//  Batch
//
//  Created by Chawtech on 31/01/24.
//

import UIKit

class QuestionAgeVC: UIViewController {
    @IBOutlet weak var customNavigationBar: CustomSecondNavigationBar!
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        datePicker.maximumDate = Date()
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            print("\(day) \(month) \(year)")
            AnswerStruct.age = year
        }
    }
    
    // MARK: - UI
    
    private func setupNavigationBar() {
        customNavigationBar.titleLbl.isHidden = false
        customNavigationBar.titleLbl.text = CustomNavTitle.qustionVCTitle.localized
    }
    

    @IBAction func nextActionBtn(_ sender: BatchButton) {
        if AnswerStruct.age == nil {
            showAlert(message: "Please select your date of birth".localized)
        }  else {
            let vc = QuestionHeightVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
    }

}
