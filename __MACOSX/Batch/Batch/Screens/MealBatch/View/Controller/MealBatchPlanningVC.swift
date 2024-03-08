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
    @IBOutlet weak var lblCountOfSelectedDishes: UILabel!
    @IBOutlet weak var lblSelectedCategoryDishesCount: UILabel!
    // MARK: - Properties
    var isCommingFrom = ""
    var mealData : SubscribedMeals!
    var subscribedMealDetails: SubscribedMealDetails?
    var weekDays : [DateEntry] = []
    var selectedWeekDay: DateEntry?    
    var selectedMealCategory: CategoryList?
    var dishesList : [Dishes] = []

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mealCollView.delegate = self
        self.setupNavigationBar()
        updateSelectedDishCount()
        self.getDishesListApi()
    }
    
    func updateSelectedDishCount() {
        if let categoryArray = self.subscribedMealDetails?.mealDetails.categoryList {
            self.lblCountOfSelectedDishes.text = "\(self.selectedWeekDay?.dishes?.count ?? 0)/\(categoryArray.count)"
        }
        if let selectedCategoryID = selectedMealCategory?.categoryID, let dishes = selectedWeekDay?.dishes {
            let selectedCategoryDishesCount = dishes.filter { $0.dishCategory == selectedCategoryID }.count
            print("Count of dishes for selected category: \(selectedCategoryDishesCount)")
            self.lblSelectedCategoryDishesCount.text = "Selected \(selectedCategoryDishesCount)/1"
        } else {
            print("Either selectedWeekDay?.dishes or selectedMealCategory?.categoryID is nil.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.weekCalenderCollView.reloadData()
            self.mealCategoryCollView.reloadData()
            self.mealCollView.reloadData()
        }
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
    
    func reloadTheMealCollectionView() {
        DispatchQueue.main.async {
            self.updateSelectedDishCount()
            self.mealCollView.reloadData()
        }
    }
    
    func updateMealBatchRequest(dishesRecord: String) {
        if let subscribedId = self.subscribedMealDetails?.subscribeDetail.subscribedID, let mealId = mealData.id {
            let updateMealBatchRequest = UpdateBatchMealPlanRequest(userId: "1", subscribedId: "\(subscribedId)", mealId: "\(mealId)", dayDishes: dishesRecord)
            DispatchQueue.main.async {
                showLoading()
            }
            let bMealViewModel = BMealBatchPlanningViewModel()
            let urlStr = API.subscriptionMealUpdate
            
            bMealViewModel.updateBatchMealPlan(urlStr: urlStr, request: updateMealBatchRequest) { (response) in
                if response.status == true {
                    DispatchQueue.main.async {
                        hideLoading()
                        self.dismiss(animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        hideLoading()
                        self.dismiss(animated: true)
                    }
                }
            } onError: { (error) in
                DispatchQueue.main.async {
                    hideLoading()
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    // MARK: - IBActions
    @IBAction func onTapNextBtn(_ sender: Any) {
        var daysDishes = [String: [String: [String: DaysDish]]]()
        if let dishes = selectedWeekDay?.dishes {
            let mappedDishes = dishes.reduce(into: [String: [String: DaysDish]]()) { result, dish in
                let key = String(dish.dishID)
                let categoryKey = String(dish.dishCategory)
                
                if result[key] == nil {
                    result[key] = [String: DaysDish]()
                }
                
                result[key]?[categoryKey] = dish
            }

            // Use mappedDishes dictionary here
            if let selectedDayOfMonth = selectedWeekDay?.dayOfMonth {
                daysDishes[selectedDayOfMonth] = mappedDishes
            }
        }

        let encoder = JSONEncoder()
        do {
            // Encode the array into JSON data
            let jsonData = try encoder.encode(daysDishes)
            // Convert JSON data to a string
            guard let jsonString = String(data: jsonData, encoding: .utf8) else {
                return
            }
            print(jsonString)
            updateMealBatchRequest(dishesRecord: jsonString)
        } catch {
            print("Error encoding dishes array: \(error)")
            dismiss(animated: true)
        }
        
        //        let vc = MealBatchPlanningVC.instantiate(fromAppStoryboard: .batchMealPlans)
        //        vc.modalPresentationStyle = .overFullScreen
        //        vc.modalTransitionStyle = .coverVertical
        //        self.present(vc, animated: true)
    }
    
}

extension MealBatchPlanningVC {
    //Get Dishes List
    public func getDishesListApi() {
        DispatchQueue.main.async {
            showLoading()
        }
        self.dishesList.removeAll()
        let bMealViewModel = BMealViewModel()
        guard let mealId = mealData.id else {
            return
        }
        let urlStr = API.dishesList + "\(mealId)"
        bMealViewModel.dishesList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                self.dishesList = response.data?.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    if let cell = self.mealCategoryCollView.cellForItem(at: IndexPath(item: 0, section: 0)) as? BMealCategoryCollCell {
                        cell.bgView.backgroundColor = Colors.appViewPinkBackgroundColor
                        self.mealCategoryCollView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)

                    } else {
                        // Handle the case when the cell is not available
                        print("Cell is not available")
                    }
                    self.reloadTheMealCollectionView()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.reloadTheMealCollectionView()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.reloadTheMealCollectionView()
            }
        }
    }
}

extension UICollectionView {
    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
        for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
    }
}
