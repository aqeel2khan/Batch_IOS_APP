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
        
        tblView.register(UINib(nibName: "QuestionLabelTVC", bundle: .main), forCellReuseIdentifier: "QuestionLabelTVC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.getDietList()
    }
    
    // MARK: - UI
    
    private func setupNavigationBar() {
        customNavigationBar.titleLbl.isHidden = false
        customNavigationBar.titleLbl.text = CustomNavTitle.qustionVCTitle.localized
    }
    
    @IBAction func nextActionBtn(_ sender: BatchButton) {
        var selectedValue : [Int] = []
        
        for indexPath in tblView.indexPathsForSelectedRows ?? [] {
            selectedValue.append(self.dietList[indexPath.row].id)
        }
        
        let commaSeperatedString = (selectedValue.map{String($0)}.joined(separator: ","))
        
        if commaSeperatedString == "" {
            showAlert(message: "Please select at least one diet".localized)
        } else {
            AnswerStruct.tag_id = commaSeperatedString
            let vc = QuestionAllergyVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
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
                self.dietList = response.data.data 
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
