//
//  MealBatchDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 27/01/24.
//

import UIKit

class MealBatchDetailVC: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var customSecondNavigationBar: CustomSecondNavigationBar!
    @IBOutlet weak var mealPriceLbl: UILabel!
    @IBOutlet weak var weekCalenderCollView: UICollectionView!// 202
    @IBOutlet weak var mealTblView: UITableView!
    @IBOutlet weak var mealTblViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tagCollView: UICollectionView! //201
    @IBOutlet weak var tagCollViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var mealMsgBackView: UIView!
    
    // MARK: - Properties
    var isCommingFrom = ""
    var tagTitleArray = ["1700-1800 kcal","3-4 meals","Vegan"]
    var tagIconArray = [#imageLiteral(resourceName: "flash-black"), #imageLiteral(resourceName: "meal_Black"), #imageLiteral(resourceName: "Filled")]
    
    var weekDayNameArr  = ["SUN","MON","TUE", "WED", "THU", "FRI", "SAT"]
    var weekDateArr     = ["01","02","03", "04", "05", "06", "07"]
    var sectionTitleArr = ["Breakfast","Lunch","Dinner"]
    
    // private let cornerRadius: CGFloat = 24
    //var calenderWeekDataArr = ["weekName":["SUN","MON","TUE", "WED", "THU", "FRI", "SAT"]]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpTagCollView()
        self.setupNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.weekCalenderCollView.reloadData()
        self.mealTblView.reloadData()
        self.mealTblView.addObserver(self, forKeyPath: BatchConstant.contentSize, options: .new, context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {

        self.mealTblView.removeObserver(self, forKeyPath: BatchConstant.contentSize)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update height constraint
        self.tagCollViewHeightConstraint.constant = self.tagCollView.collectionViewLayout.collectionViewContentSize.height
        tagCollView.reloadData()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == BatchConstant.contentSize
        {
            if let newValue = change?[.newKey]
            {
                let newsize = newValue as! CGSize
                self.mealTblViewHeightConstraint.constant = newsize.height
            }
        }
    }
    // MARK: - UI
    
    private func setupNavigationBar() {
      //  self.customSecondNavigationBar.titleLbl.text = ""
        self.registerCollTblView()
        self.setUpMealDetailViewData()
    }
    
    private func registerCollTblView(){
        self.tagCollView.register(BatchTrainingDetailCollCell.self)
        self.weekCalenderCollView.register(weekCalenderCollCell.self)
        self.mealTblView.registerCell(BMealTblCell.self)
    }
    
    private func setUpTagCollView(){
        let leftLayout = leftSideDataInColl()
        leftLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        tagCollView.collectionViewLayout = leftLayout
    }
    
    private func setUpMealDetailViewData()
    {
        if isCommingFrom == "MealBatchVCWithSubscribeBatch"
        {
            self.mealPriceLbl.isHidden      = true
            self.mealMsgBackView.isHidden   = false
            self.mealTblView.isHidden       = true
        }
        /*
         else if isCommingFrom == "MealBatchVCWithOutSubscribeBatch"
         {
         }
         */
    }
    
    // MARK: - IBActions
    
    @IBAction func onTapMealPlanningBtn(_ sender: Any) {
       // let vc = MealBatchPlanningVC.instantiate(fromAppStoryboard: .batchMealPlans)
       // let vc = QuestionGoalVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
        let vc = ShowTotalBurnerCaloryVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
}
