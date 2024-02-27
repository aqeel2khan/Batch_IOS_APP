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
    @IBOutlet weak var nameLbl: UILabel!

    var selectedMealData : Meals!
    var dishData : Dishes!
    var nutritionList : [NutritionDetail] = []

    // MARK: - Properties
    var isCommingFrom = ""

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        
        nameLbl.text = dishData.name
        self.getDishesDetailsApi()
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

    //Get Dishes Details
    public func getDishesDetailsApi(){

        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.dishesDetail + "?dish_id=\(dishData.dishID ?? 0)&meal_id=\(selectedMealData.id ?? 0)&goal_id=\(selectedMealData.goalID ?? 0)"
        bMealViewModel.dishesDetail(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data != nil {
                
                self.nutritionList.removeAll()
                self.nutritionList = response.data?.data?.nutritionDetails ?? []

                DispatchQueue.main.async {
                    hideLoading()

                    self.showProtinListCollView.reloadData()

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
