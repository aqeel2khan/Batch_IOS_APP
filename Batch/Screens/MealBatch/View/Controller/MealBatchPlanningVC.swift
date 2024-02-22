//
//  MealBatchPlanningVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 27/01/24.
//

import UIKit

class MealBatchPlanningVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var customSecondNavigationBar: CustomSecondNavigationBar!
    
    @IBOutlet weak var weekCalenderCollView: UICollectionView!// 601
    @IBOutlet weak var mealCategoryCollView: UICollectionView! //602
    @IBOutlet weak var mealCollView: UICollectionView! //603
    @IBOutlet weak var mealCollViewHeightConstraint: NSLayoutConstraint!
    
    
    // MARK: - Properties
    var isCommingFrom = ""
    var weekDayNameArr  = ["SUN","MON","TUE", "WED", "THU", "FRI", "SAT"]
    var weekDateArr     = ["01","02","03", "04", "05", "06", "07"]
    var mealCategoryTitleArr = ["Breakfast","Lunch & Dinner", "Snack", "Desserts"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.weekCalenderCollView.reloadData()
        self.mealCategoryCollView.reloadData()
        self.mealCollView.reloadData()
        self.mealCollView.addObserver(self, forKeyPath: BatchConstant.contentSize, options: .new, context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.mealCollView.removeObserver(self, forKeyPath: BatchConstant.contentSize)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update height constraint
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == BatchConstant.contentSize
        {
            if let newValue = change?[.newKey]
            {
                let newsize = newValue as! CGSize
                self.mealCollViewHeightConstraint.constant = newsize.height
            }
        }
    }
    // MARK: - UI
    
    private func setupNavigationBar() {
        self.customSecondNavigationBar.titleLbl.isHidden = false
        self.customSecondNavigationBar.titleLbl.text = "Meal Planning"
        self.customSecondNavigationBar.rightBarBtnItem2.isHidden = false
        
        self.registerCollTblView()
    }
    
    private func registerCollTblView(){
        self.weekCalenderCollView.register(weekCalenderCollCell.self)
        self.mealCategoryCollView.register(BMealCategoryCollCell.self)
        self.mealCollView.register(BMealCollCell.self)
    }
    
    // MARK: - IBActions
    
    @IBAction func onTapNextBtn(_ sender: Any) {
       
        dismiss(animated: true)
        
        //        let vc = MealBatchPlanningVC.instantiate(fromAppStoryboard: .batchMealPlans)
        //        vc.modalPresentationStyle = .overFullScreen
        //        vc.modalTransitionStyle = .coverVertical
        //        self.present(vc, animated: true)
    }
    
}
