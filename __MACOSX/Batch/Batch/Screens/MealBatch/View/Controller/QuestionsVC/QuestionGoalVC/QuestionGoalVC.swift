//
//  QuestionGoalVC.swift
//  Batch
//
//  Created by Chawtech on 31/01/24.
//

import UIKit

struct AnswerStruct {
    static var goal_id : Int?
    static var age : Int?
    static var height : String = "0"
    static var current_weight : String = "0"
    static var target_weight : String = "0"
    static var workout_per_week : String?
    static var tag_id : String?
    static var allergic_id : String?
}


class QuestionGoalVC: UIViewController {
    @IBOutlet weak var customNavigationBar: CustomSecondNavigationBar!
    @IBOutlet weak var tblView: UITableView!
    var goalList : [QuestionGoal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        tblView.register(UINib(nibName: "QuestionLabelTVC", bundle: .main), forCellReuseIdentifier: "QuestionLabelTVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.getGoalList()
    }
    
    // MARK: - UI
    private func setupNavigationBar() {
        customNavigationBar.titleLbl.isHidden = false
        customNavigationBar.titleLbl.text = CustomNavTitle.qustionVCTitle
    }
    
    @IBAction func nextActionBtn(_ sender: BatchButton) {
        if AnswerStruct.goal_id == nil {
            showAlert(message: "Please select at least one goal")
        } else {
            let vc = QuestionAgeVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
    }
    
    //Get Goal List
    private func getGoalList(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.goalList
        bMealViewModel.goalList(requestUrl: urlStr)  { (response) in
            self.goalList.removeAll()
            if response.status == true, response.data?.data?.count != 0 {
                self.goalList = response.data?.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.tblView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                }
            }
            
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
            }
        }
        
    }
}
