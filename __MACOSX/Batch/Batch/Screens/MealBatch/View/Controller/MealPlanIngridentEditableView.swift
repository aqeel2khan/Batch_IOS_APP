//
//  MealPlanIngridentEditableView.swift
//  Batch
//
//  Created by Chawtech on 28/01/24.
//

import UIKit

class MealPlanIngridentEditableView: UIViewController {
    
    var  ingridentlist = ["Salmon","Eggs","Whole grain bread","Cottage cheese",]
    // MARK: - IBOutlets
    
    @IBOutlet weak var customSecondNavigationBar: CustomSecondNavigationBar!
  
    @IBOutlet weak var showProtinListCollView: UICollectionView!
    @IBOutlet weak var planReviewCollView: UICollectionView!
    @IBOutlet weak var mealTblView: UITableView!
    @IBOutlet weak var mealTblViewHeightConstraint: NSLayoutConstraint!
    

    // MARK: - Properties
    var isCommingFrom = ""

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }


    // MARK: - UI
    
    private func setupNavigationBar() {
        self.customSecondNavigationBar.titleLbl.text = ""
        self.registerCollTblView()
    }
    
    private func registerCollTblView(){
        
        showProtinListCollView.delegate = self
        showProtinListCollView.dataSource = self
        
        planReviewCollView.delegate = self
        planReviewCollView.dataSource = self
        
        mealTblView.delegate = self
        mealTblView.dataSource = self
                
        self.showProtinListCollView.register(MealPlanProtienCollectionViewCell.self)
        self.planReviewCollView.register(ReviewIngridentCollectionViewCell.self)
        self.mealTblView.registerCell(MealPlanIngridentTableCell.self)
    }

}
