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
    
    @IBOutlet weak var ingridentLabelView: UILabel!
    @IBOutlet weak var reviewsCountLabel: UILabel!
    
    @IBOutlet weak var rateMealLabel: UILabel!


    var selectedMealData : Meals!
    var dishData : Dishes!
    var nutritionList : [NutritionDetail] = []
    var dishReviews : DishReviews?
    var dishRequest: DishRequest?
    // MARK: - Properties
    var isCommingFrom = ""

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Enable user interaction
        rateMealLabel.isUserInteractionEnabled = true
        
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        rateMealLabel.addGestureRecognizer(tapGesture)

        self.setupNavigationBar()
        self.getDishesDetailsApi()
    }
    
    @objc func labelTapped() {
        // Call your function here
        openRatingScreen()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getDishesReviewsList()
    }

    // MARK: - UI
    
    private func setupNavigationBar() {
        self.mealTblView.isHidden = true
        self.ingridentLabelView.isHidden = false

        self.customSecondNavigationBar.titleLbl.text = ""
        self.registerCollTblView()
        if isCommingFrom == "MealBatchUnSubscribeDetailVC" {
            nameLbl.text = dishData.name
        } else {
            nameLbl.text = dishRequest?.dishName
        }
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
    public func getDishesDetailsApi() {

        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        var urlStr = ""
        if isCommingFrom == "MealBatchUnSubscribeDetailVC" {
            urlStr = API.dishesDetail + "?dish_id=\(dishData.dishID ?? 0)&meal_id=\(selectedMealData.id ?? 0)&goal_id=\(selectedMealData.goalID ?? 0)"
        } else {
            urlStr = API.dishesDetail + "?dish_id=\(dishRequest?.dishId ?? "0")&meal_id=\(dishRequest?.mealId ?? "0")&goal_id=\(dishRequest?.goalId ?? "0")"
        }
        bMealViewModel.dishesDetail(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data != nil {
                self.nutritionList.removeAll()
                self.nutritionList = response.data?.data?.nutritionDetails ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    let nutrientNames = self.nutritionList.compactMap { $0.nutrientName }
                    let commaSeparatedNutrientNames = nutrientNames.joined(separator: ", ")
                    self.ingridentLabelView.text = commaSeparatedNutrientNames
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
    
    //Get Dishes Details
    public func getDishesReviewsList() {
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        var urlStr = ""
        if isCommingFrom == "MealBatchUnSubscribeDetailVC" {
            urlStr = API.dishesReviewList + "\(dishData.dishID ?? 0)"
        } else {
            urlStr = API.dishesReviewList + "\(dishRequest?.dishId ?? "0")"
        }
        bMealViewModel.getDishReviewList(requestUrl: urlStr)  { (response) in
            if response.status == true {
                self.dishReviews = response.data
                DispatchQueue.main.async {
                    hideLoading()
                    self.planReviewCollView.reloadData()
                    if self.dishReviews?.data.count == 0 {
                        self.reviewsCountLabel.text = ""
                    } else {
                        self.reviewsCountLabel.text = "Reviews(\(self.dishReviews?.data.count ?? 0))"
                    }
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.reviewsCountLabel.text = ""
                    self.planReviewCollView.reloadData()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.reviewsCountLabel.text = ""
                self.planReviewCollView.reloadData()
            }
        }
    }
    
    func openRatingScreen() {
        let vc = MealplanRatingVC.instantiate(fromAppStoryboard: .batchMealPlans)
        var dishId = ""
        if isCommingFrom == "MealBatchUnSubscribeDetailVC" {
            dishId = "\(dishData.dishID ?? 0)"
        } else {
            dishId = "\(dishRequest?.dishId ?? "0")"
        }
        vc.postReviewRequest = PostReviewRequest(userId: "\(UserDefaultUtility().getUserId())", dishId: dishId, rating: "", review: "")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
}
