//
//  QuestionAllergyVC.swift
//  Batch
//
//  Created by Chawtech on 31/01/24.
//

import UIKit
import SDWebImage

class QuestionAllergyVC: UIViewController {
    
    @IBOutlet weak var customNavigationBar: CustomSecondNavigationBar!
    @IBOutlet weak var allergyCollectionView: UICollectionView!
    var algeryList : [Allergy] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setupNavigationBar()
        
        allergyCollectionView.allowsMultipleSelection = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getAllergyList()
    }
    
    private func setupNavigationBar() {
        customNavigationBar.titleLbl.isHidden = false
        customNavigationBar.titleLbl.text = CustomNavTitle.qustionVCTitle.localized
    }
    
    // MARK:- setUP CollectionView
    
    func setUpCollectionView() {
        allergyCollectionView.delegate = self
        allergyCollectionView.dataSource = self
        allergyCollectionView.register(UINib(nibName: "QuestionAllergyCollectionCell", bundle: .main), forCellWithReuseIdentifier: "QuestionAllergyCollectionCell")
        
    }
    
    @IBAction func nextActionBtn(_ sender: BatchButton) {
        var selectedValue : [Int] = []
        
        for indexPath in allergyCollectionView.indexPathsForSelectedItems ?? [] {
            selectedValue.append(self.algeryList[indexPath.row].id)
        }
        
        let commaSeperatedString = (selectedValue.map{String($0)}.joined(separator: ","))
        
        if commaSeperatedString == "" {
            showAlert(message: "Please select at least one allergy".localized)
        } else {
            AnswerStruct.allergic_id = commaSeperatedString
            
            let vc = WelcomeVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
    }
    
    //Get Allerty List
    private func getAllergyList(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.allergiesList
        bMealViewModel.allergiesList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data.data.count != 0 {
                self.algeryList = response.data.data
                DispatchQueue.main.async {
                    hideLoading()
                    self.allergyCollectionView.reloadData()
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
