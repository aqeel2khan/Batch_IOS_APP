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
    @IBOutlet weak var mealPlanCollView: UICollectionView!
    @IBOutlet weak var mealPlanTblView: UITableView!
    @IBOutlet weak var mealPlanTblViewHeightConstraint: NSLayoutConstraint!
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mealPlanCollView.reloadData()
        self.mealPlanTblView.reloadData()
        self.mealPlanTblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
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
        self.registerCollTblView()
    }
    
    private func registerCollTblView(){
//        self.mealPlanCollView.register(BWOBatchesListCollCell.self)
//        self.mealPlanTblView.register(BWOMotivatorsListCollCell.self)
        
        mealPlanTblView.register(UINib(nibName: "MealPlanTVC", bundle: .main), forCellReuseIdentifier: "MealPlanTVC")
        mealPlanCollView.register(UINib(nibName: "MealPlanCollectionCell", bundle: .main), forCellWithReuseIdentifier: "MealPlanCollectionCell")
        
        mealPlanTblView.register(UINib(nibName: "MealPlanBottomCell", bundle: .main), forCellReuseIdentifier: "MealPlanBottomCell")


        

    }
}
