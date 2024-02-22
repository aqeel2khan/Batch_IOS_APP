//
//  QuestionDietVC.swift
//  Batch
//
//  Created by Chawtech on 31/01/24.
//

import UIKit

class QuestionDietVC: UIViewController {

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
        
        let vc = QuestionAllergyVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }



}
