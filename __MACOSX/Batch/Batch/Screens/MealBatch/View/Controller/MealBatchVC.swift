//
//  MealBatchVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import UIKit

class MealBatchVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
//    @IBOutlet weak var mealPlanCollView: UICollectionView!
    @IBOutlet weak var mealPlanTblView: UITableView!
    @IBOutlet weak var mealPlanTblViewHeightConstraint: NSLayoutConstraint!
    var mealListData = [Meals]()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.mealPlanCollView.reloadData()
        self.mealPlanTblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        getMealList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.mealPlanTblView.removeObserver(self, forKeyPath: "contentSize")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"
        {
            if let newValue = change?[.newKey]
            {
                let newsize = newValue as! CGSize
                self.mealPlanTblViewHeightConstraint.constant = newsize.height
            }
        }
    }
    // MARK: - UI
    
    private func setupNavigationBar() {
        customNavigationBar.titleFirstLbl.text = CustomNavTitle.mealBatchVCNavTitle
        self.registerTblView()
    }
    
    private func registerTblView(){
//        self.mealPlanCollView.register(BWOBatchesListCollCell.self)
//        self.mealPlanTblView.register(BWOMotivatorsListCollCell.self)
        
        mealPlanTblView.register(UINib(nibName: "MealPlanTVC", bundle: .main), forCellReuseIdentifier: "MealPlanTVC")
//        mealPlanCollView.register(UINib(nibName: "MealPlanCollectionCell", bundle: .main), forCellWithReuseIdentifier: "MealPlanCollectionCell")
    }
    
    @IBAction func calculateBtnTap(_ sender: Any) {
        let vc = QuestionGoalVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    
    // MARK: - API Call
    
    //Get Meal List
    private func getMealList(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.mealList
        bMealViewModel.mealList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                self.mealListData = response.data?.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.mealPlanTblView.reloadData()
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
