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
    var weekDays : [DateEntry] = []
    var selectedWeekDay: DateEntry?    
    var mealCategoryArr : [CategoryList] = [
        CategoryList(categoryID: 1, categoryName: "Breakfast"),
        CategoryList(categoryID: 2, categoryName: "Lunch & Dinner"),
        CategoryList(categoryID: 3, categoryName: "Snack"),
        CategoryList(categoryID: 4, categoryName: "Desserts")
    ]
    var dishesList : [Dishes] = []

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        if let category = mealCategoryArr.first, let categoryID = category.categoryID {
            self.getDishesListApi(mealCateogryId: categoryID)
        }
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
        if keyPath == BatchConstant.contentSize {
            if let newValue = change?[.newKey] {
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
        self.mealCollView.register(BMealDishCollCell.self)
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

extension MealBatchPlanningVC {
    //Get Dishes List
    public func getDishesListApi(mealCateogryId:Int) {
        DispatchQueue.main.async {
            showLoading()
        }
        self.dishesList.removeAll()
        let bMealViewModel = BMealViewModel()
        let urlStr = API.dishesList + "\(mealCateogryId)"
        bMealViewModel.dishesList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                self.dishesList = response.data?.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    if let cell = self.mealCategoryCollView.cellForItem(at: IndexPath(item: 0, section: 0)) as? BMealCategoryCollCell {
                        cell.bgView.backgroundColor = Colors.appViewPinkBackgroundColor
                    } else {
                        // Handle the case when the cell is not available
                        print("Cell is not available")
                    }
                    self.mealCategoryCollView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                    self.mealCollView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.mealCollView.reloadData()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.mealCollView.reloadData()
            }
        }
    }
}
