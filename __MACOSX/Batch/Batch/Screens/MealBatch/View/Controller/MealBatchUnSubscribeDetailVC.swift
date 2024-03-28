//
//  MealBatchUnSubscribeDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 29/01/24.
//

import UIKit

class MealBatchUnSubscribeDetailVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var customSecondNavigationBar: CustomSecondNavigationBar!

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var grandTotalLbl: UILabel!

    @IBOutlet weak var tagCollView: UICollectionView! //701
    @IBOutlet weak var tagCollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mealCategoryCollView: UICollectionView! //702
    
    @IBOutlet weak var dishesCollView: UICollectionView! //703
    @IBOutlet weak var mealCollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomBackView: UIView!
    var mealData : Meals!

    // MARK: - Properties
    var isCommingFrom = ""
    var tagTitleArray : [String] = []
    var tagIconArray = [#imageLiteral(resourceName: "flash-black"), #imageLiteral(resourceName: "meal_Black"), #imageLiteral(resourceName: "Filled")]    
    var mealCategoryArr : [CategoryList] = []
    var dishesList : [Dishes] = []
    var isMealSubscribed: CheckSubscribedMeal?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = mealData.name
        titleLbl.font = FontSize.mediumSize20
        let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(mealData.price ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
        priceLbl.attributedText = attributedPriceString
        descLbl.text = mealData.description
        descLbl.font = FontSize.regularSize14
        durationLbl.text = (getDuration()) + " weeks"
        let fileUrl = URL(string: BaseUrl.imageBaseUrl + (mealData.image ?? ""))
        self.imgView.sd_setImage(with: fileUrl , placeholderImage:UIImage(named: "Meal"))
        self.setUpTagCollView()
        self.getMealDetails()
        
        if UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE) as? String  == ARABIC_LANGUAGE_CODE {
            tagCollView.semanticContentAttribute = .forceLeftToRight
            tagCollView.transform = CGAffineTransform(scaleX: -1, y: 1)
            
            dishesCollView.semanticContentAttribute = .forceLeftToRight
            dishesCollView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
    }
    
    func getDuration() -> String {
        let arrayofOptions = mealData.duration?.components(separatedBy: ",").map { String($0) } ?? []
        if arrayofOptions.count > 0 {
            return arrayofOptions.first ?? "1"
        } else {
            return mealData.duration ?? "1"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MealSubscriptionManager.shared.reset()
        self.setupNavigationBar()
        self.dishesCollView.addObserver(self, forKeyPath: BatchConstant.contentSize, options: .new, context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.dishesCollView.removeObserver(self, forKeyPath: BatchConstant.contentSize)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update height constraint
        self.tagCollViewHeightConstraint.constant = self.tagCollView.collectionViewLayout.collectionViewContentSize.height
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
     //   self.customSecondNavigationBar.titleLbl.text = ""
        self.registerCollTblView()
        self.setUpMealDetailViewData()
    }
    
    private func registerCollTblView(){
        self.tagCollView.register(BatchTrainingDetailCollCell.self)
        self.mealCategoryCollView.register(BMealCategoryCollCell.self)
        self.dishesCollView.register(BMealDishCollCell.self)
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
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func onTapSubscribePlanBtn(_ sender: UIButton) {
        if UserDefaultUtility.isUserLoggedIn() {
//            self.checkIfMealIsAlreadySubscribed()
            self.getSubscribedMealList()
        } else {
            let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
            // let vc = BRegistrationVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
            vc.isCommingFrom = "MealBatchSubscribe"
            MealSubscriptionManager.shared.duration = self.getDuration()
            vc.mealData = mealData
            vc.CallBackToUpdateProfile = {
                self.viewWillAppear(true)
            }
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
    }
    
    func goToCheckoutScreen() {
        let vc = MealPlanCheckout.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
        vc.isCommingFrom = "MealBatchSubscribe"
        vc.mealData = self.mealData
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapAddPromoCodeBtn(_ sender: UIButton) {
        let vc = BPromoCodePopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    //Get Meal Details
    private func getMealDetails(){

        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.mealDetail + "\(mealData.id ?? 0)"
        bMealViewModel.mealDetail(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data != nil {
                self.tagTitleArray.append((response.data?.data?.avgCalPerDay ?? "") + " " + BatchConstant.kcalSuffix)
                self.tagTitleArray.append(("\(response.data?.data?.mealCount ?? 0)") + " " + BatchConstant.meals)
                self.tagTitleArray.append((response.data?.data?.mealType ?? ""))
                self.mealCategoryArr = response.data?.data?.categoryList ?? []

              
                DispatchQueue.main.async {
                    hideLoading()
                    if let durationString = response.data?.data?.duration,
                       let duration = Double(durationString),
                       let priceString = response.data?.data?.price,
                       let price = Double(priceString) {
                        // Use duration and price safely
                        let grandTotal = duration * price
                        self.grandTotalLbl.text = "KD" + String(format: "%.2f", grandTotal)
                    } else {
                        // Handle the case where either duration or price is nil or cannot be converted to Double
                        self.grandTotalLbl.text = "KD 0.00"
                    }
                    self.tagCollView.reloadData()
                    self.mealCategoryCollView.reloadData()
                    
                    if self.mealCategoryArr.count > 0 {
                        self.getDishesListApi(mealCateogryId: self.mealCategoryArr[0].categoryID!)
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
    
    //Get Dishes List
    public func getDishesListApi(mealCateogryId:Int){

        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.dishesList + "\(mealCateogryId)"
        bMealViewModel.dishesList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                
                self.dishesList.removeAll()
                self.dishesList = response.data?.data ?? []

                DispatchQueue.main.async {
                    hideLoading()
                    let cell : BMealCategoryCollCell = self.mealCategoryCollView.cellForItem(at: IndexPath(item: 0, section: 0)) as! BMealCategoryCollCell
                    cell.bgView.backgroundColor = Colors.appViewPinkBackgroundColor
                    self.mealCategoryCollView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
                    self.dishesCollView.reloadData()
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
    
    func checkIfMealIsAlreadySubscribed() {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.subscriptionMealcheckSubscribed
        
        let request = CheckSubscribedRequest(userId: "\(UserDefaultUtility().getUserId())", mealId: "\(mealData.id ?? 0)")
        
        bMealViewModel.checkIfMealIsSubscribed(urlStr: urlStr, request: request)  { (response) in
            if response.status == true, response.data?.data != nil {
                self.isMealSubscribed = response.data?.data
                DispatchQueue.main.async {
                    hideLoading()
                    if let isAlreadySubscribed = self.isMealSubscribed?.subscribed, isAlreadySubscribed == 1 {
                        self.showAlert(message: "Already Subscribed")
                    } else {
                        // Proceed to purchase
                        MealSubscriptionManager.shared.duration = self.getDuration()
                        self.goToCheckoutScreen()
                    }
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.showAlert(message: "Something Wrong")
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: "Something Wrong")
            }
        }
    }
    
    private func getSubscribedMealList() {
        DispatchQueue.main.async {
            self.showLoader()
        }
        
        let bHomeViewModel = DashboardViewModel()
        let urlStr = API.subscriptionMealList
        let request = SubscribedMealListRequest(userId: "\(UserDefaultUtility().getUserId())")
        bHomeViewModel.getSubscribedMealList(urlStr: urlStr, request: request) { (response) in
            if response.status == true {
                let totalRecords = response.data?.recordsTotal ?? 0
                DispatchQueue.main.async {
                    hideLoading()
                    if totalRecords == 0 {
                        MealSubscriptionManager.shared.duration = self.getDuration()
                        self.goToCheckoutScreen()
                    } else {
                        self.showAlert(message: "User can not subscribed more than 1 Meal Plan.")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    hideLoading()
                    self.showAlert(message: "Something Wrong")
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: "Something Wrong")
            }
        }
    }
    
    private func showLoader() {
        DispatchQueue.main.async {
            showLoading()
        }
    }

}

extension MealBatchUnSubscribeDetailVC: OptionPickerDelegate {
    func showOptionPicker() {
        let vc = OptionPickerViewController.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        let options = ["Option 1", "Option 2", "Option 3"]
        vc.pickerOptions = mealData.duration?.components(separatedBy: ",").map { String($0) } ?? []
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - OptionPickerDelegate
    
    func didSelectOption(_ option: String) {
        print("Selected option: \(option)")
        // Handle the selected option as needed
        MealSubscriptionManager.shared.duration = option
    }

}
