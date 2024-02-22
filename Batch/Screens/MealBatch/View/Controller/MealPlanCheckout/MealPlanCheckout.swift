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
        let vc = BThankyouPurchaseVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.isCommingFrom = "MealPlanCheckout"
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true )
    }
}
