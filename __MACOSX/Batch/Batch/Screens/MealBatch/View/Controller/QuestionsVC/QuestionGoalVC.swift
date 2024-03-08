//
//  QuestionGoalVC.swift
//  Batch
//
//  Created by Chawtech on 31/01/24.
//

import UIKit

struct AnswerInputStruct {
    static var goal_id = ""
    static var age = ""
    static var height = ""
    static var current_weight = ""
    static var target_weight = ""
    static var workout_per_week = ""
    static var tag_id = ""
    static var allergic_id = ""
}

class QuestionGoalVC: UIViewController {
    
    @IBOutlet weak var customNavigationBar: CustomSecondNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    // MARK: - UI
    
    private func setupNavigationBar() {
        customNavigationBar.titleLbl.isHidden = false
        customNavigationBar.titleLbl.text = CustomNavTitle.qustionVCTitle
    }
    
    @IBAction func nextActionBtn(_ sender: BatchButton) {
        
        let vc = QuestionAgeVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
}
