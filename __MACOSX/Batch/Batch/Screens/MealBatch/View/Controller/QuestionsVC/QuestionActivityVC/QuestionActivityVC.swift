//
//  QuestionActivityVC.swift
//  Batch
//
//  Created by Chawtech on 31/01/24.
//

import UIKit

class QuestionActivityVC: UIViewController {
    @IBOutlet weak var customNavigationBar: CustomSecondNavigationBar!
    @IBOutlet weak var tblView: UITableView!
    var activityList : [String] = ["Low Mobility", "1-2 workouts per week", "3-5 workouts per week", "5-7 workouts per week"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        tblView.register(UINib(nibName: "QuestionLabelTVC", bundle: .main), forCellReuseIdentifier: "QuestionLabelTVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tblView.reloadData()
    }
    
    // MARK: - UI
    private func setupNavigationBar() {
        customNavigationBar.titleLbl.isHidden = false
        customNavigationBar.titleLbl.text = CustomNavTitle.qustionVCTitle
    }
    
    @IBAction func nextActionBtn(_ sender: BatchButton) {
        if tblView.indexPathsForSelectedRows?.count ?? 0 > 0 {
            AnswerInputStruct.workout_per_week = self.activityList[(tblView.indexPathsForSelectedRows?[0].row)!]
        }
        
        if AnswerInputStruct.workout_per_week == nil {
            showAlert(message: "Please select at least one active option")
        }  else {
            let vc = QuestionDietVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
    }
}
