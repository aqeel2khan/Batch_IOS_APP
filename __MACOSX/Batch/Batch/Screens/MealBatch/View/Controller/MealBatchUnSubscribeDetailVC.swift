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

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLbl.text = mealData.name
        priceLbl.text = "from $ \(mealData.price ?? "")" 
        descLbl.text = mealData.description
        durationLbl.text = (mealData.duration ?? "") + " weeks"
        
        self.setUpTagCollView()
        self.setupNavigationBar()
        
        self.getMealDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        self.dishesCollView.register(BMealCollCell.self)
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
    
    //Get Meal Details
    private func getMealDetails(){

        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.mealDetail + "\(mealData.id ?? 0)"
        bMealViewModel.mealDetail(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data != nil {
                
                
                self.tagTitleArray.append((response.data?.data?.avgCalPerDay ?? "") + " kcal")
                self.tagTitleArray.append(("\(response.data?.data?.mealCount ?? 0)") + " meals")
                self.tagTitleArray.append((response.data?.data?.mealType ?? ""))
                
                self.mealCategoryArr = response.data?.data?.categoryList ?? []

                if self.mealCategoryArr.count > 0 {
                    self.getDishesListApi(mealCateogryId: self.mealCategoryArr[0].categoryID!)
                }

                DispatchQueue.main.async {
                    hideLoading()
                    let duration : Double = Double(response.data?.data?.duration ?? "0")!
                    let price : Double = Double(response.data?.data?.price ?? "0")!
                    self.grandTotalLbl.text = "$" + "\(duration * price)"
                    self.tagCollView.reloadData()
                    self.mealCategoryCollView.reloadData()
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
    
}
