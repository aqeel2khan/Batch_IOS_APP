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
    var subscribedMealDetails : SubscribedMealDetails?
    @IBOutlet weak var mealMsgBackView: UIView!
    
    // MARK: - Properties
    var isCommingFrom = ""
    
    var tagTitleArray : [String] = []
    var tagIconArray = [#imageLiteral(resourceName: "flash-black"), #imageLiteral(resourceName: "meal_Black"), #imageLiteral(resourceName: "Filled")]
    var mealCategoryArr : [CategoryList] = []
    var dishesList : [Dishes] = []
    var weekDays : [DateEntry] = []
    var selectedWeekDay: DateEntry?
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.mealTitleLbl.text = mealData.name
        self.mealTitleLbl.font = FontSize.mediumSize20
        let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(mealData.price ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
        self.mealPriceLbl.attributedText = attributedPriceString

        self.mealDescriptionLbl.text = mealData.description
        self.mealDescriptionLbl.font = FontSize.regularSize14
        self.durationLbl.text = (mealData.duration ?? "") + " weeks"
        self.durationLbl.font = FontSize.mediumSize12
        self.mealMsgBackView.isHidden = true
        self.mealTblView.addObserver(self, forKeyPath: BatchConstant.contentSize, options: .new, context: nil)
        self.setUpTagCollView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
        self.getSubscribedMealDetails()
    }
    override func viewWillDisappear(_ animated: Bool) {
        // self.mealTblView.removeObserver(self, forKeyPath: BatchConstant.contentSize)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update height constraint
        self.tagCollViewHeightConstraint.constant = self.tagCollView.collectionViewLayout.collectionViewContentSize.height
        tagCollView.reloadData()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == BatchConstant.contentSize {
            if let newValue = change?[.newKey] {
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
        vc.weekDays = self.weekDays
        vc.selectedWeekDay = self.selectedWeekDay
        vc.mealData = mealData
        vc.subscribedMealDetails = subscribedMealDetails
        vc.modalPresentationStyle = .fullScreen
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
        request.userId = "\(UserDefaultUtility().getUserId())"
        if let subscribedId = mealData.subscribedId {
            request.subscribedId = "\(subscribedId)"
        }
        if let mealId = mealData.id {
            request.mealId = "\(mealId)"
        }
        request.goalId = "1"
        self.tagTitleArray.removeAll()
        self.weekDays.removeAll()
        bHomeViewModel.getSubscribedMealDetail(urlStr: urlStr, request: request) { (response) in
            if response.status == true, response.data?.data != nil {
                DispatchQueue.main.async {
                    self.tagTitleArray.append((response.data?.data?.mealDetails.avgCalPerDay ?? "") + " " + BatchConstant.kcalSuffix)
                    self.tagTitleArray.append(("\(response.data?.data?.mealDetails.mealCount ?? 0)") + " " + BatchConstant.meals)
                    self.tagTitleArray.append((response.data?.data?.mealDetails.mealType ?? ""))
                    hideLoading()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.timeZone = TimeZone(identifier: "Asia/Kolkata") // Set timezone to Indian Standard Time (IST)

                    if let subscribeMealDetails = response.data?.data {
                        self.subscribedMealDetails = subscribeMealDetails
                    }
                    if let subscribeDetail = response.data?.data?.subscribeDetail {
                        self.mealSubscribeDetail = subscribeDetail
                        if let startDate = dateFormatter.date(from: response.data?.data?.subscribeDetail.startDate ?? ""),
                           let endDate = dateFormatter.date(from: response.data?.data?.subscribeDetail.endDate ?? "") {
                            let weekDays = self.datesBetween(startDate: startDate, endDate: endDate)
                            self.weekDays = weekDays
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.tagCollView.reloadData()
                        self.weekCalenderCollView.reloadData()
                        self.weekCalenderCollView.collectionViewLayout.invalidateLayout()
                        self.weekCalenderCollView.layoutSubviews()
                        if self.weekDays.count > 0 {
                            if let matchingWeekday = self.weekDays.first(where: { $0.day == DateHelper.getDay(from: Date()) }),
                               let index = self.weekDays.firstIndex(where: { $0.day == DateHelper.getDay(from: Date()) }) {
                                self.selectedWeekDay = matchingWeekday
                                self.weekCalenderCollView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                            } else {
                                self.selectedWeekDay = self.weekDays.first
                                self.weekCalenderCollView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                            }
                            if let dish = self.selectedWeekDay?.dishes, dish.count > 0 {
                                self.mealMsgBackView.isHidden = true
                            } else {
                                self.mealMsgBackView.isHidden = false
                            }
                            self.mealTblView.reloadData()
                        }
                    }
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
    func datesBetween(startDate: Date, endDate: Date) -> [DateEntry] {
        var currentDate = startDate
        var datesArray = [DateEntry]()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Setting locale to ensure consistent formatting

        while currentDate <= endDate {
            // Check if currentDate is within the specified range
            if currentDate >= startDate && currentDate <= endDate {
                let dayName = calendar.shortWeekdaySymbols[calendar.component(.weekday, from: currentDate) - 1]
                let dayOfMonth = dateFormatter.string(from: currentDate)
                let month = calendar.component(.month, from: currentDate)
                let date = calendar.component(.day, from: currentDate)
                var dateEntry = DateEntry(month: month, day: date,dayName: dayName, dayOfMonth: dayOfMonth, date: currentDate)
                
                if let dishes = self.mealSubscribeDetail.daysDishes[dayOfMonth] {
                    for (_, dayDict) in dishes {
                        for (_, dish) in dayDict {
                            let daysDish = DaysDish(dishID: dish.dishID,
                                                    dishName: dish.dishName,
                                                    dishImage: dish.dishImage,
                                                    dishCategory: dish.dishCategory,
                                                    month: dish.month,
                                                    day: dish.day,
                                                    selected: dish.selected, calories: dish.calories)
                            dateEntry.dishes?.append(daysDish)
                        }
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
    
    func openMealIngredientView(dishId: String, dishName: String) {
        let vc = MealPlanIngridentEditableView.instantiate(fromAppStoryboard: .batchMealPlans)
        vc.isCommingFrom = "MealBatchDetailVC"
        if let mealId = mealData.id, let goalId = mealData.goalID {
            vc.dishRequest = DishRequest(mealId: "\(mealId)", dishId: dishId, goalId: "\(goalId)", dishName: dishName)
        }
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
}

struct DishRequest {
    let mealId: String
    let dishId: String
    let goalId: String
    let dishName: String
}
