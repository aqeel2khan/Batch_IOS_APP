//
//  QuestionDietVC.swift
//  Batch
//
//  Created by Chawtech on 31/01/24.
//

import UIKit

class QuestionDietVC: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var customNavigationBar: CustomSecondNavigationBar!
    var dietList : [Diet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        tblView.register(UINib(nibName: "QuestionDietTVC", bundle: .main), forCellReuseIdentifier: "QuestionDietTVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.getDietList()
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


    //Get Diet List
    private func getDietList(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.typeOfDiegtList
        bMealViewModel.dietList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data.data.count != 0 {
                self.dietList = response.data.data ?? []
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
