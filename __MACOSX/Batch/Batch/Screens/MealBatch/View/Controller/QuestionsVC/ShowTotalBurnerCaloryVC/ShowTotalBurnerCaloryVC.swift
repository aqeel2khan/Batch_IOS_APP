//
//  ShowTotalBurnerCaloryVC.swift
//  Batch
//
//  Created by Chawtech on 02/02/24.
//

import UIKit

class ShowTotalBurnerCaloryVC: UIViewController {
    @IBOutlet weak var averageCaloryPerDayLbl: UILabel!
    @IBOutlet weak var mealPlanTblView: UITableView!
    @IBOutlet weak var mealPlanTblViewHeightConstraint: NSLayoutConstraint!
    
    var averageCalory: Int = 0
    var mealListData : [Meals] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerTblView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mealPlanTblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.submitAllAnswers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.mealPlanTblView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    private func registerTblView(){
        mealPlanTblView.register(UINib(nibName: "MealPlanTVC", bundle: .main), forCellReuseIdentifier: "MealPlanTVC")
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey] {
                let newsize = newValue as! CGSize
                self.mealPlanTblViewHeightConstraint.constant = newsize.height
            }
        }
    }
    
    @IBAction func backToSwitchToHomeBtnTap(_ sender: UIButton) {
        let vc = BatchTabBarController.instantiate(fromAppStoryboard: .batchTabBar)
        tabBarController?.selectedIndex = 1
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            Batch_AppDelegate.window?.rootViewController = vc
        }
    }
    
    // MARK: - API Call
    func submitAllAnswers() {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.submitQuestionAnswers
        
        let request = AnswerRequest.init(goal_id: "\(AnswerStruct.goal_id!)", age: "\(AnswerStruct.age!)", height: AnswerStruct.height, current_weight: AnswerStruct.current_weight, target_weight: AnswerStruct.target_weight, workout_per_week: AnswerStruct.workout_per_week!, tag_id: AnswerStruct.tag_id!, allergic_id: AnswerStruct.allergic_id!)
        
        bMealViewModel.questionAnswer(requestUrl: urlStr, request: request)  { (response) in
            if response.status == true {
                DispatchQueue.main.async {
                    hideLoading()
                    self.averageCalory = Int(response.data.data.avg_cal_per_day) ?? 0
                    self.averageCaloryPerDayLbl.text = "\(self.averageCalory)"
                                        
                    var request = MealFilterRequest(caloriesFrom: nil, caloriesTo: nil, goalID: nil, tagId: nil)
//                    request.goalID = "2"
//                    request.tagId = "2,5"
//                    request.caloriesFrom = "100"
//                    request.caloriesTo = "1500"
//
                    request.goalID = "\(AnswerStruct.goal_id!)"
                    request.tagId = AnswerStruct.tag_id
                    request.caloriesFrom = "\(self.averageCalory - 50)"
                    request.caloriesTo = "\(self.averageCalory + 50)"
                    self.applyFiltersToMealList(request: request)
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
    
    // Apply Filters on Meal
    private func applyFiltersToMealList(request: MealFilterRequest) {
        self.mealListData.removeAll()
        DispatchQueue.main.async {
            showLoading()
        }
        
        let bMealViewModel = BMealViewModel()
        let urlStr = API.mealList
        bMealViewModel.applyFilterToMealList(urlStr: urlStr, request: request) { (response) in
            self.resetAnswerStruct()
            if response.status == true, response.data?.data?.count != 0 {
                self.mealListData = response.data?.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.mealPlanTblView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    hideLoading()
                    self.mealPlanTblView.reloadData()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.mealPlanTblView.reloadData()
            }
        }
    }

    func resetAnswerStruct() {
        AnswerStruct.goal_id = nil
        AnswerStruct.age = nil
        AnswerStruct.height = ""
        AnswerStruct.current_weight = ""
        AnswerStruct.target_weight = ""
        AnswerStruct.workout_per_week = ""
        AnswerStruct.tag_id = ""
        AnswerStruct.allergic_id = ""
    }
}
