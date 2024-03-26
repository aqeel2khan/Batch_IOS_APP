//
//  MealPlanCheckout.swift
//  Batch
//
//  Created by Chawtech on 26/01/24.
//

import UIKit

class MealPlanCheckout: UIViewController {

    var deliverImages = [#imageLiteral(resourceName: "calendar-green"), #imageLiteral(resourceName: "location 3"), #imageLiteral(resourceName: "clock"), #imageLiteral(resourceName: "Combo shape"), #imageLiteral(resourceName: "open box 1")]
    var deliverTitles = ["Select Start date of plan","Add address","Delivery time","Delivery arriving","Drop off"]
    
    @IBOutlet weak var tableViewHeightContant: NSLayoutConstraint!
    @IBOutlet weak var delivertTableView: UITableView!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: BatchLabelRegularWhite!
    @IBOutlet weak var kclLbl: UILabel!
    @IBOutlet weak var mealsLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!

    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var promotion: UILabel!
    @IBOutlet weak var total: UILabel!

    
    var mealData : Meals!
    var isCommingFrom = ""
    var grandTotal = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupTableView()
        
        self.titleLbl.text = mealData.name
        
        guard let durationString = MealSubscriptionManager.shared.duration, let priceString = mealData.price, let price = Double(priceString), let duration = Double(durationString)  else {
            return
        }
        grandTotal = Double(duration) * Double(price)

        let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(grandTotal)", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
        self.priceLbl.attributedText = attributedPriceString
        
        let originalString = "\(mealData.avgCalPerDay ?? "") \(BatchConstant.kcalSuffix)"
        let keyword = BatchConstant.kcalSuffix
        let attributedString = NSAttributedString.attributedStringWithDifferentFonts(for: originalString, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword)
        self.kclLbl.attributedText = attributedString
        let original2String = "\(mealData.mealCount ?? 0) meals"
        let keyword2 = "meals"
        let attributedString1 = NSAttributedString.attributedStringWithDifferentFonts(for: original2String, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword2)
        self.mealsLbl.attributedText = attributedString1
        
        self.subtotal.attributedText = NSAttributedString.attributedStringForPrice(prefix: "", value: " \(CURRENCY) \(grandTotal)", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
        self.promotion.text = "0.0"
        self.total.attributedText = NSAttributedString.attributedStringForPrice(prefix: "", value: " \(CURRENCY) \(grandTotal)", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
        self.durationLbl.text = "\(MealSubscriptionManager.shared.duration ?? "1") weeks"
        
        let keyword3 = "Weeks"
        let attributedString3 = NSAttributedString.attributedStringWithDifferentFonts(for: "\(MealSubscriptionManager.shared.duration ?? "1") Weeks", prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword3)
        self.durationLbl.attributedText = attributedString3
        self.fetchData()
    }
    
    override func viewWillLayoutSubviews() {
        tableViewHeightContant.constant = CGFloat(deliverTitles.count * 68)
    }
    
   func  setupTableView() {
       delivertTableView.register(UINib(nibName: "MealPlanCheckoutCell", bundle: .main), forCellReuseIdentifier: "MealPlanCheckoutCell")
    }

    @IBAction func backActionBtn(_ sender: UIButton) {
        MealSubscriptionManager.shared.reset()
        self.dismiss(animated: true)
    }
    
    func validateData() -> (isValid: Bool, errorMessage: String) {
        if MealSubscriptionManager.shared.startDate == nil || MealSubscriptionManager.shared.startDate?.isEmpty == true {
            return (false, "Start date is required.".localized)
        }
        
        if MealSubscriptionManager.shared.duration == nil || MealSubscriptionManager.shared.duration?.isEmpty == true {
            return (false, "Duration is required.".localized)
        }
        
        if MealSubscriptionManager.shared.area == nil || MealSubscriptionManager.shared.area?.isEmpty == true {
            return (false, "Area is required.".localized)
        }
        
        if MealSubscriptionManager.shared.block == nil || MealSubscriptionManager.shared.block?.isEmpty == true {
            return (false, "Block is required.")
        }
        
        if MealSubscriptionManager.shared.house == nil || MealSubscriptionManager.shared.house?.isEmpty == true {
            return (false, "House is required.".localized)
        }
        
        if MealSubscriptionManager.shared.street == nil || MealSubscriptionManager.shared.street?.isEmpty == true {
            return (false, "Street is required.".localized)
        }
        
        if MealSubscriptionManager.shared.addressType == nil || MealSubscriptionManager.shared.addressType?.isEmpty == true {
            return (false, "Address type is required.".localized)
        }
        
        if MealSubscriptionManager.shared.deliveryTime == nil || MealSubscriptionManager.shared.deliveryTime?.isEmpty == true {
            return (false, "Delivery time is required.".localized)
        }
        
        if MealSubscriptionManager.shared.deliveryArriving == nil || MealSubscriptionManager.shared.deliveryArriving?.isEmpty == true {
            return (false, "Delivery arriving is required.".localized)
        }
        
        if MealSubscriptionManager.shared.deliveryDropoff == nil || MealSubscriptionManager.shared.deliveryDropoff?.isEmpty == true {
            return (false, "Delivery dropoff is required.".localized)
        }
        
        // Add validation for other properties here if needed
        
        return (true, "")
    }

    
    @IBAction func onTapCheckOutBtn(_ sender: Any) {
        let (isValid, errorMessage) = validateData()
        if isValid {
            // Data is valid, proceed further
            let vc = BPaymentGatewayPopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            vc.totalOrderAmount = "\(self.grandTotal)"
            if isCommingFrom == "MealBatchSubscribe" {
                vc.mealData = mealData
            }
            vc.completion = { (transactionID) in
                self.createMealSubscriptionApi(mealId: self.mealData.id ?? 0, subtotal: "\(self.grandTotal)", discount: 0, total: "\(self.grandTotal)", paymentType: "card", transactionID: transactionID, paymentStatus: "true")
            }
            self.present(vc, animated: true )
        } else {
            // Show error message to the user
            showAlert(message: errorMessage)
        }
    }
    
    private func createMealSubscriptionApi(mealId:Int, subtotal:String, discount:Int, total:String, paymentType:String, transactionID:String, paymentStatus:String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        
        MealSubscriptionManager.shared.userId = UserDefaultUtility().getUserId()
        MealSubscriptionManager.shared.mealId = mealId
        MealSubscriptionManager.shared.subtotal = subtotal
        MealSubscriptionManager.shared.discount = "\(discount)"
        MealSubscriptionManager.shared.tax = 0
        MealSubscriptionManager.shared.total = total
        MealSubscriptionManager.shared.paymentType = paymentType
        MealSubscriptionManager.shared.transactionId = transactionID
        MealSubscriptionManager.shared.paymentStatus = paymentStatus
        MealSubscriptionManager.shared.city = "Siwani"
        MealSubscriptionManager.shared.cityId = "2"
        MealSubscriptionManager.shared.state = "Haryan"
        MealSubscriptionManager.shared.stateId = "5"

        guard let req = MealSubscriptionManager.shared.createSubscriptionRequest() else {
            return
        }
        DispatchQueue.main.async {
            showLoading()
        }
        let bCheckoutViewModel = BCheckoutViewModel()
        bCheckoutViewModel.createMealSubscriptionCall(request: req)  { (response) in
            if response.status == true {
                DispatchQueue.main.async {
                    hideLoading()
                    let vc = BThankyouPurchaseVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
                    vc.isCommingFrom = "MealBatchSubscribe"
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .coverVertical
                    self.present(vc, animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.showAlert(message: response.message ?? "Api issue")
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: "\(error.localizedDescription)")
            }
        }
    }
}


extension MealPlanCheckout {
    
    func fetchData() {
        let dispatchGroup = DispatchGroup()
        
        // Enter the DispatchGroup before making each API call
        dispatchGroup.enter()
        getDeliveryArrivingOptions(dispatchGroup: dispatchGroup)
        
        dispatchGroup.enter()
        getDeliveryTimeSlots(dispatchGroup: dispatchGroup)
        
        dispatchGroup.enter()
        getDeliveryDropOffOptions(dispatchGroup: dispatchGroup)
        
        // Notify when all tasks are completed
        dispatchGroup.notify(queue: .main) {
            // Reload the table view once all API calls are completed
            self.delivertTableView.delegate = self
            self.delivertTableView.dataSource = self

            self.delivertTableView.reloadData()
            
            self.delivertTableView.transform = CGAffineTransform(translationX: self.delivertTableView.frame.width, y: 0)
            UIView.animate(
                withDuration: 0.5,
                delay: 0.05,
                options: [.curveEaseInOut],
                animations: {
                    self.delivertTableView.transform = CGAffineTransform(translationX: 0, y: 0)
                })

            hideLoading()
        }
    }
    
    func getDeliveryArrivingOptions(dispatchGroup: DispatchGroup) {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealCoViewModel = BMealPlanCheckoutViewModel()
        let urlStr = API.deliveryArrivingList
        bMealCoViewModel.getDeliveryArrivingSlots(requestUrl: urlStr)  { (response) in
            defer {
                // Leave the DispatchGroup whether the call succeeds or fails
                dispatchGroup.leave()
            }
            if response.status == true, response.data?.data?.count != 0 {
                DispatchQueue.main.async {
                    hideLoading()
                    MealSubscriptionManager.shared.deliveryArriving = response.data?.data?[0].options
                    MealSubscriptionManager.shared.deliveryArrivingId = response.data?.data?[0].id
                }
            } else {
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
    
    func getDeliveryTimeSlots(dispatchGroup: DispatchGroup) {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealCoViewModel = BMealPlanCheckoutViewModel()
        let urlStr = API.deliveryTimeList
        bMealCoViewModel.getDeliveryTimeSlots(requestUrl: urlStr)  { (response) in
            defer {
                dispatchGroup.leave()
            }
            if response.status == true, let data = response.data?.data, !data.isEmpty {
                DispatchQueue.main.async {
                    hideLoading()
                    MealSubscriptionManager.shared.deliveryTime = data[0].timeSlot
                    MealSubscriptionManager.shared.deliveryTimeId = data[0].id
                }
            } else {
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
    
    func getDeliveryDropOffOptions(dispatchGroup: DispatchGroup) {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealCoViewModel = BMealPlanCheckoutViewModel()
        let urlStr = API.deliveryDropOffList
        bMealCoViewModel.getDeliveryDropOffSlots(requestUrl: urlStr)  { (response) in
            defer {
                dispatchGroup.leave()
            }
            if response.status == true, let data = response.data?.data, !data.isEmpty {
                DispatchQueue.main.async {
                    hideLoading()
                    MealSubscriptionManager.shared.deliveryDropoff = data[0].options
                    MealSubscriptionManager.shared.deliveryDropoffId = data[0].id
                }
            } else {
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
