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

    @IBOutlet weak var tagCollView: UICollectionView! //701
    @IBOutlet weak var tagCollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mealCategoryCollView: UICollectionView! //702
    @IBOutlet weak var mealCollView: UICollectionView! //703
    @IBOutlet weak var mealCollViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomBackView: UIView!
    var mealData : Meals!

    // MARK: - Properties
    var isCommingFrom = ""
    var tagTitleArray : [String] = []
    var tagIconArray = [#imageLiteral(resourceName: "flash-black"), #imageLiteral(resourceName: "meal_Black"), #imageLiteral(resourceName: "Filled")]    
    var mealCategoryTitleArr = ["Breakfast","Lunch & Dinner", "Snack", "Desserts"]

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagTitleArray.append((mealData.avgCalPerDay ?? "") + " kcal")
        tagTitleArray.append((mealData.avgCalPerDay ?? "") + " meals")
        tagTitleArray.append((mealData.avgCalPerDay ?? "") + " Vegan")
        
        tagCollView.reloadData()

        titleLbl.text = mealData.name
        priceLbl.text = "from $ \(mealData.price ?? "")" 
        descLbl.text = mealData.description
        durationLbl.text = (mealData.duration ?? "") + " weeks"
        
        self.setUpTagCollView()
        self.setupNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mealCategoryCollView.reloadData()
        self.mealCollView.reloadData()
        self.mealCollView.addObserver(self, forKeyPath: BatchConstant.contentSize, options: .new, context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.mealCollView.removeObserver(self, forKeyPath: BatchConstant.contentSize)
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
        self.mealCollView.register(BMealCollCell.self)
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
        /*
         else if isCommingFrom == "MealBatchVCWithOutSubscribeBatch"
         {
         }
         */
    }
    
    // MARK: - IBActions
    
    @IBAction func onTapSubscribePlanBtn(_ sender: UIButton) {
        let vc = BRegistrationVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
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
    
}
