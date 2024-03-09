//
//  ShowTotalBurnerCaloryVC.swift
//  Batch
//
//  Created by Chawtech on 02/02/24.
//

import UIKit

class ShowTotalBurnerCaloryVC: UIViewController {
    @IBOutlet weak var averageCaloryPerDayLbl: UILabel!
    
    var averageCalory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.submitAllAnswers()
    }

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
                    self.averageCalory = response.data.data.avg_cal_per_day
                    self.averageCaloryPerDayLbl.text = self.averageCalory
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
    
    @IBAction func backActinBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func nextActionBtn(_ sender: UIButton) {
        self.switchToHomeVC()
    }
    
    func switchToHomeVC() {
            let vc = BatchTabBarController.instantiate(fromAppStoryboard: .batchTabBar)
            tabBarController?.selectedIndex = 1
            if #available(iOS 13.0, *) {
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            } else {
                Batch_AppDelegate.window?.rootViewController = vc
            }
        }
}
