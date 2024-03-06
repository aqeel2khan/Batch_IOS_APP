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
    @IBOutlet weak var mealPlanTblView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mealPlanTblViewHeightConstraint: NSLayoutConstraint!
    var mealListData : [Meals] = []
    var searchmealListData : [Meals] = []
    var filterOptionData : FilterData!
    var timer: Timer? = nil

    var storedSelectedWorkOut : [Int] = []
    var storedSelectedLevel : [Int] = []
    var storedSelectedGoal : [Int] = []

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
        getFilterOptionList()
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
        mealPlanTblView.register(UINib(nibName: "MealPlanTVC", bundle: .main), forCellReuseIdentifier: "MealPlanTVC")
        mealPlanTblView.register(UINib(nibName: "MealPlanBannerViewTVC", bundle: .main), forCellReuseIdentifier: "MealPlanBannerViewTVC")
      }
    
    @IBAction func filterBtnTap(_ sender: Any) {
        let vc = MealFilterVC.instantiate(fromAppStoryboard: .batchMealPlans)
        vc.firstArray = filterOptionData.mealCalories ?? []
        vc.secondArray = filterOptionData.batchGoals ?? []
        vc.thirdArray = filterOptionData.mealTags ?? []
        vc.selectedWorkOut = self.storedSelectedWorkOut
        vc.selectedGoal = self.storedSelectedGoal
        vc.selectedLevel = self.storedSelectedLevel
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.completionFilters = { (selectedWorkout, selectedLevel, selectedGoal) in
            self.saveSelectedFiltersForLocalCache(selectedWorkout: selectedWorkout, selectedLevel: selectedLevel, selectedGoal: selectedGoal)
            self.processFiltersAndMakeApiCall()
        }
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
    
    //Get Meal List
    private func getFilterOptionList(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.filterOption
        bMealViewModel.filterOption(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data != nil {
                DispatchQueue.main.async {
                    hideLoading()
                    self.filterOptionData = response.data?.data
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

extension MealBatchVC {
    func saveSelectedFiltersForLocalCache(selectedWorkout: [Int], selectedLevel:[Int], selectedGoal:[Int]) {
        self.storedSelectedWorkOut = selectedWorkout
        self.storedSelectedLevel = selectedLevel
        self.storedSelectedGoal = selectedGoal
    }
    
    func processFiltersAndMakeApiCall() {
        let commaSeparatedWorkOutStr = self.storedSelectedWorkOut.map{String($0)}.joined(separator: ",")
        let commaSeparatedLevelStr = self.storedSelectedLevel.map{String($0)}.joined(separator: ",")
        let commaSeparatedGoalStr = self.storedSelectedGoal.map{String($0)}.joined(separator: ",")
        
        let filteredSelectedWorkout = filterOptionData.mealCalories?.first { value in
            value.id == Int(commaSeparatedWorkOutStr)
        }
        var request = MealFilterRequest(caloriesFrom: nil, caloriesTo: nil, goalID: nil, tagId: nil)
        if filteredSelectedWorkout != nil {
            if let fromValue = filteredSelectedWorkout?.fromValue {
                request.caloriesFrom = "\(fromValue)"
            }
            if let toValue = filteredSelectedWorkout?.toValue {
                request.caloriesFrom = "\(toValue)"
            }
        }
        if !commaSeparatedLevelStr.isEmpty {
            request.tagId = commaSeparatedLevelStr
        }
        if !commaSeparatedGoalStr.isEmpty {
            request.goalID = commaSeparatedGoalStr
        }
        dump(request)
        if request.caloriesFrom != nil || request.caloriesTo != nil || request.goalID != nil || request.tagId != nil {
            self.applyFiltersToMealList(request: request)
        } else {
            print("No filters applied")
            self.getMealList()
        }
    }
    
    // Apply Filters to Apply
    private func applyFiltersToMealList(request: MealFilterRequest) {
        self.mealListData.removeAll()
        DispatchQueue.main.async {
            showLoading()
        }
        
        let bMealViewModel = BMealViewModel()
        let urlStr = API.mealList
        bMealViewModel.applyFilterToMealList(urlStr: urlStr, request: request) { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                self.mealListData = response.data?.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.mealPlanTblView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    hideLoading()
                    self.mealPlanTblView.reloadData()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.mealPlanTblView.reloadData()
            }
        }
    }

}
