//
//  MealPlanCheckout.swift
//  Batch
//
//  Created by Chawtech on 26/01/24.
//

import UIKit

class MealPlanCheckout: UIViewController {

    var deliverImages = [#imageLiteral(resourceName: "calendar-green"), #imageLiteral(resourceName: "location 3"), #imageLiteral(resourceName: "clock"), #imageLiteral(resourceName: "Combo shape"), #imageLiteral(resourceName: "open box 1")]
    var deliverTitles = ["Start date of plan","Add address","Delivery time","Delivery arriving","Drop off"]
    
    @IBOutlet weak var tableViewHeightContant: NSLayoutConstraint!
    @IBOutlet weak var delivertTableView: UITableView!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: BatchLabelRegularWhite!
    @IBOutlet weak var kclLbl: UILabel!
    @IBOutlet weak var mealsLbl: UILabel!

    @IBOutlet weak var subtotal: UILabel!
    @IBOutlet weak var promotion: UILabel!
    @IBOutlet weak var total: UILabel!


    var mealData : Meals!
    var isCommingFrom = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delivertTableView.delegate = self
        delivertTableView.dataSource = self
        
        setupTableView()
        
        self.titleLbl.text = mealData.name
        let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(mealData.price ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
        self.priceLbl.attributedText = attributedPriceString
        
        let originalString = "\(mealData.avgCalPerDay ?? "") \(BatchConstant.kcalSuffix)"
        let keyword = BatchConstant.kcalSuffix
        let attributedString = NSAttributedString.attributedStringWithDifferentFonts(for: originalString, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword)
        self.kclLbl.attributedText = attributedString
        let original2String = "\(mealData.mealCount ?? 0) meals"
        let keyword2 = "meals"
        let attributedString1 = NSAttributedString.attributedStringWithDifferentFonts(for: original2String, prefixFont: UIFont(name:"Outfit-Medium",size:16)!, suffixFont: UIFont(name:"Outfit-Medium",size:12)!, keyword: keyword2)
        self.mealsLbl.attributedText = attributedString1
        
        self.subtotal.attributedText = NSAttributedString.attributedStringForPrice(prefix: "", value: " \(CURRENCY) \(mealData.price ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
        self.promotion.text = "0.0"
        self.total.attributedText = NSAttributedString.attributedStringForPrice(prefix: "", value: " \(CURRENCY) \(mealData.price ?? "")", prefixFont: UIFont(name:"Outfit-Medium",size:10)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
    }
    
    override func viewWillLayoutSubviews() {
        tableViewHeightContant.constant = CGFloat(deliverTitles.count * 68)
    }
    
   func  setupTableView() {
       delivertTableView.register(UINib(nibName: "MealPlanCheckoutCell", bundle: .main), forCellReuseIdentifier: "MealPlanCheckoutCell")
    }

    @IBAction func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onTapCheckOutBtn(_ sender: Any) {
        let vc = BPaymentGatewayPopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.modalPresentationStyle = .pageSheet
        vc.modalTransitionStyle = .coverVertical
        vc.totalOrderAmount = mealData.price ?? "0"
        if isCommingFrom == "MealBatchSubscribe" {
            vc.mealData = mealData
        }
        vc.completion = { (transactionID) in
            if let price = self.mealData.price {
                self.createMealSubscriptionApi(mealId: self.mealData.id ?? 0, subtotal: price, discount: 0, total: price, paymentType: "card", transactionID: transactionID, paymentStatus: "true")
            }
        }
        self.present(vc, animated: true )
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
        MealSubscriptionManager.shared.startDate = dateFormatter.string(from:Date())
        MealSubscriptionManager.shared.duration = mealData.duration

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
