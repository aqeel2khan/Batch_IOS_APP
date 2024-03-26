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
    
    @IBOutlet weak var subContainerView: UIView! //603

    // MARK: - Properties
    var isCommingFrom = ""
    var mealData : SubscribedMeals!
    var subscribedMealDetails: SubscribedMealDetails?
    var weekDays : [DateEntry] = []
    var selectedWeekDay: DateEntry?    
    var selectedMealCategory: SubscribedCategoryList?
    var dishesList : [CategoryDish] = []

    var allCategories = [SubscribedCategoryList]()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mealCollView.delegate = self
        self.setupNavigationBar()
        if let categoryDic = self.subscribedMealDetails?.mealDetails.categoryList {
            for (_, category) in categoryDic {
                allCategories.append(category)
            }
        }
        DispatchQueue.main.async {
            if self.allCategories.count > 0 {
                self.selectedMealCategory = self.allCategories.first
                if let categoryId = self.selectedMealCategory?.categoryID {
                    self.reloadTheDishCollectionViewAsPerCategoryId(categoryId: categoryId)
                }
                self.updateTheCategorySelectionInCollectionView()
            }
        }
        updateTheWeekCalendarCollectionView()
        updateSelectedDishCount()
        animateTheContainerView()
    }
    
    func updateTheCategorySelectionInCollectionView() {
        self.mealCategoryCollView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    func animateTheContainerView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.subContainerView.transform = CGAffineTransform(translationX: self.subContainerView.frame.width, y: 0)
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05,
                options: [.curveEaseInOut],
                animations: {
                    self.subContainerView.transform = CGAffineTransform(translationX: 0, y: 0)
                })
        }
    }
    
    func updateTheWeekCalendarCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let selectedWeekDay = self.selectedWeekDay,
               let index = self.weekDays.firstIndex(where: { $0.dayName == selectedWeekDay.dayName && $0.dayOfMonth == selectedWeekDay.dayOfMonth }) {
                print("Index of selectedWeekDay: \(index)")
                self.weekCalenderCollView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            } else {
                print("SelectedWeekDay not found in weekDays array")
            }
        }
    }
    
    func updateSelectedDishCount() {
        self.lblCountOfSelectedDishes.text = "\(self.selectedWeekDay?.dishes?.count ?? 0)/\(allCategories.count)"
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        self.customSecondNavigationBar.leftBarBtnItem.setImage(UIImage(named: "back"), for: .normal)
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
    
    func reloadTheDishCollectionViewAsPerCategoryId(categoryId: Int) {
        self.dishesList.removeAll()
        if let filteredDishes = filterDishes(forCategoryID: categoryId) {
            self.dishesList = filteredDishes
            reloadTheMealCollectionView()
        }
    }
    
    func filterDishes(forCategoryID categoryID: Int) -> [CategoryDish]? {
        guard let categoryDic = self.subscribedMealDetails?.mealDetails.categoryList else {
            return nil // Return nil if category dictionary is nil
        }
        
        // Find category with the specified categoryID
        if let category = categoryDic[String(categoryID)] {
            // Get all dishes for the category
            let dishes = category.categoryDishes.values.map { $0 }
            return dishes
        } else {
            return nil // Return nil if category with specified ID is not found
        }
    }
    
    func updateMealBatchRequest(dishesRecord: String) {
        if let subscribedId = self.subscribedMealDetails?.subscribeDetail.subscribedID, let mealId = mealData.id, let selectedDay = selectedWeekDay {
            let updateMealBatchRequest = UpdateBatchMealPlanRequest(userId: "\(UserDefaultUtility().getUserId())", subscribedId: "\(subscribedId)", mealId: "\(mealId)", dayDishes: dishesRecord, day: "\(DateHelper.getDay(from: selectedDay.date))", month: "\(DateHelper.getMonth(from: selectedDay.date))")
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
        var daysDishes = [String: [String: DaysDish]]()
        if let dishes = selectedWeekDay?.dishes {
            let mappedDishes = dishes.reduce(into: [String: DaysDish]()) { result, dish in
                let key = String(dish.dishID)
                let categoryKey = String(dish.dishCategory)
                if result[categoryKey] == nil {
                    result[categoryKey] = dish
                }
                result[categoryKey] = dish
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
    }
}
