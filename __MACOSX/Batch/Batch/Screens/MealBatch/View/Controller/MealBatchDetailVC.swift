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
    @IBOutlet weak var mealTitleLbl: UILabel!
    @IBOutlet weak var mealDescriptionLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!

    @IBOutlet weak var weekCalenderCollView: UICollectionView!// 202
    @IBOutlet weak var mealTblView: UITableView!
    @IBOutlet weak var mealTblViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tagCollView: UICollectionView! //201
    @IBOutlet weak var tagCollViewHeightConstraint: NSLayoutConstraint!
    var mealData : SubscribedMeals!
    var mealSubscribeDetail : SubscribeDetail!

    @IBOutlet weak var mealMsgBackView: UIView!
    
    // MARK: - Properties
    var isCommingFrom = ""
    
    var tagTitleArray : [String] = []
    var tagIconArray = [#imageLiteral(resourceName: "flash-black"), #imageLiteral(resourceName: "meal_Black"), #imageLiteral(resourceName: "Filled")]
    var mealCategoryArr : [CategoryList] = []
    var dishesList : [Dishes] = []
    var weekDays : [DateEntry] = []
    var sectionTitleArr = ["Breakfast","Lunch","Dinner"]
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.weekCalenderCollView.reloadData()
        self.mealTblView.reloadData()
        self.mealTblView.addObserver(self, forKeyPath: BatchConstant.contentSize, options: .new, context: nil)
        
        self.mealTitleLbl.text = mealData.name
        self.mealPriceLbl.text = "from $ \(mealData.price ?? "")" 
        self.mealDescriptionLbl.text = mealData.description
        self.durationLbl.text = (mealData.duration ?? "") + " weeks"

        self.getSubscribedMealDetails()
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
    
    private func setUpWeekCollView(){
        let leftLayout = UICollectionViewFlowLayout()
        leftLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        weekCalenderCollView.collectionViewLayout = leftLayout
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
       let vc = MealBatchPlanningVC.instantiate(fromAppStoryboard: .batchMealPlans)
       // let vc = QuestionGoalVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
        // let vc = ShowTotalBurnerCaloryVC.instantiate(fromAppStoryboard: .batchMealPlanQuestionnaire)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
}

extension MealBatchDetailVC {
    //Get Meal Details
    private func getSubscribedMealDetails() {
        DispatchQueue.main.async {
            showLoading()
        }
        let bHomeViewModel = DashboardViewModel()
        let urlStr = API.subscriptionMealDetail
        var request = SubscribedMealDetailRequest()
        request.userId = "1"
        if let subscribedId = mealData.subscribedId {
            request.subscribedId = "\(subscribedId)"
        }
        if let mealId = mealData.id {
            request.mealId = "\(mealId)"
        }
        
        bHomeViewModel.getSubscribedMealDetail(urlStr: urlStr, request: request) { (response) in
            if response.status == true, response.data?.data != nil {
                self.tagTitleArray.append((response.data?.data?.mealDetails.avgCalPerDay ?? "") + " kcal")
                self.tagTitleArray.append(("\(response.data?.data?.mealDetails.mealCount ?? 0)") + " meals")
                self.tagTitleArray.append((response.data?.data?.mealDetails.mealType ?? ""))
                DispatchQueue.main.async {
                    hideLoading()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata") // Set timezone to Indian Standard Time (IST)

                    if let subscribeDetail = response.data?.data?.subscribeDetail {
                        self.mealSubscribeDetail = subscribeDetail
                        if let startDate = dateFormatter.date(from: response.data?.data?.subscribeDetail.startDate ?? ""),
                           let endDate = dateFormatter.date(from: response.data?.data?.subscribeDetail.endDate ?? "") {
                            let weekDays = self.datesBetween(startDate: startDate, endDate: endDate)
                            self.weekDays = weekDays
                        }
                    }
                    self.setUpTagCollView()
                    self.tagCollViewHeightConstraint.constant = self.tagCollView.collectionViewLayout.collectionViewContentSize.height
                    self.tagCollView.reloadData()
                    
                    self.weekCalenderCollView.reloadData()
                    self.weekCalenderCollView.collectionViewLayout.invalidateLayout()
                    self.weekCalenderCollView.layoutSubviews()

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

extension MealBatchDetailVC {
    struct DateEntry {
        let dayName: String
        let dayOfMonth: String
        var dishes: [DaysDish]? = []
    }
    
    func datesBetween(startDate: Date, endDate: Date) -> [DateEntry] {
        var currentDate = startDate
        var datesArray = [DateEntry]()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        
        while currentDate <= endDate {
            // Check if currentDate is within the specified range
            if currentDate >= startDate && currentDate <= endDate {
                let dayName = calendar.shortWeekdaySymbols[calendar.component(.weekday, from: currentDate) - 1]
                let dayOfMonth = dateFormatter.string(from: currentDate)
                var dateEntry = DateEntry(dayName: dayName, dayOfMonth: dayOfMonth)
                if let dishes = self.mealSubscribeDetail.daysDishes[dayOfMonth] {
                    for dayDishes in dishes.values {
                        dateEntry.dishes?.append(dayDishes)
                    }
                }
                datesArray.append(dateEntry)
            }
            // Move to the next day
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDate
            } else {
                break
            }
        }
        return datesArray
    }
}
