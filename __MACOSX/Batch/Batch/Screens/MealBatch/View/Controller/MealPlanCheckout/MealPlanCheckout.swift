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
    var mealData : Meals!
    var isCommingFrom = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delivertTableView.delegate = self
        delivertTableView.dataSource = self
        
        setupTableView()

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
        vc.totalOrderAmount = mealData.price
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
        let request =  CreateMealSubscriptionRequest(userId: "3",mealId: "\(mealId)", subtotal: subtotal, discount: "\(discount)", tax: "", total: total, paymentType: paymentType, transactionId: transactionID, paymentStatus: paymentStatus, startDate: dateFormatter.string(from:Date()), duration: "1")
                
        DispatchQueue.main.async {
            showLoading()
        }
        let bCheckoutViewModel = BCheckoutViewModel()
        bCheckoutViewModel.createMealSubscription(request: request)  { (response) in
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
