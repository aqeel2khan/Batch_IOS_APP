//
//  BatchBoardHomeVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import UIKit
import ImageSlideshow

class BatchBoardHomeVC: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    
    @IBOutlet weak var bannerSliderShow: ImageSlideshow!
    
    @IBOutlet weak var woBatchCollView: UICollectionView!
    @IBOutlet weak var motivatorsCollView: UICollectionView!
    @IBOutlet weak var mealBatchCollView: UICollectionView!
    @IBOutlet weak var topRatedMealCollView: UICollectionView!
    
    var courseListDataArr = [CourseDataList]()
    var coachListDataArr = [CoachListData]()
    var mealListData : [Meals] = []
    var topRatedMealListData : [Meals] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.showImagesOnSrollView(array_Images: ["banner1","banner2","banner3"])
        
        // Do any additional setup after loading the view.
        self.registerCollView()
        
        
        let token =  Batch_UserDefaults.string(forKey: UserDefaultKey.TOKEN)
        if token == nil{
            Batch_UserDefaults.set(UserDefaultKey.tokenValue, forKey: UserDefaultKey.TOKEN)
        }
        else{
            let getToken = Batch_UserDefaults.value(forKey: UserDefaultKey.TOKEN) as! String
            print(getToken)
            if getToken == UserDefaultKey.tokenValue {
                Batch_UserDefaults.set(UserDefaultKey.tokenValue, forKey: UserDefaultKey.TOKEN)
            }else{
                Batch_UserDefaults.set(getToken, forKey: UserDefaultKey.TOKEN)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setupNavigationBar()
        self.getCourses()
        self.getMotivators()
        self.getMealList()
        self.getTopRatedMealList()
    }
    
    // MARK: - UI
    private func setupNavigationBar() {
        customNavigationBar.titleFirstLbl.text = CustomNavTitle.batchBoardHomeVCNavTitle
        let getprofilePhoto = Batch_UserDefaults.value(forKey: UserDefaultKey.profilePhoto) as? Data
        if getprofilePhoto != nil{
            customNavigationBar.profileImage.image = UIImage(data: getprofilePhoto ?? Data())
        }else{
            customNavigationBar.profileImage.image = UIImage(named: "Avatar")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop the timer when the view controller is about to disappear
        // stopAutomaticScrolling()
    }
    
    private func registerCollView(){
        self.woBatchCollView.register(BWOBatchesListCollCell.self)
        self.motivatorsCollView.register(BWOMotivatorsListCollCell.self)
        self.mealBatchCollView.register(MealPlanCollectionCell.self)
        self.topRatedMealCollView.register(MealPlanCollectionCell.self)
    }
    
    // MARK: - UI Action
    @IBAction func onTapShowAllBtn(_ sender: UIButton) {
        switch sender.tag {
        case 152:
            self.tabBarController?.selectedIndex = 1
        case 153:
            self.tabBarController?.selectedIndex = 1
        case 154:
            self.tabBarController?.selectedIndex = 1
        case 155:
            self.tabBarController?.selectedIndex = 1
        default: break
        }
    }
}

extension BatchBoardHomeVC {
    //Get Course List
    private func getCourses(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bWorkOutViewModel = BWorkOutViewModel()
        let urlStr = API.courseList
        bWorkOutViewModel.courseList(requestUrl: urlStr)  { (response) in
            
            if response.status == true, response.data?.list?.count != 0 {
                self.courseListDataArr.removeAll()
                self.courseListDataArr = response.data?.list ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.woBatchCollView.reloadData()
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
    
    //Get Coach List
    private func getMotivators(){
        DispatchQueue.main.async {
            showLoading()
        }
        let bWorkOutViewModel = BWorkOutViewModel()
        let urlStr = API.coachList
        bWorkOutViewModel.coachList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data != nil{
                self.coachListDataArr.removeAll()
                self.coachListDataArr = response.data ?? []
                
                DispatchQueue.main.async {
                    hideLoading()
                    self.motivatorsCollView.reloadData()
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
    
    //Get Meal List
    private func getMealList(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.mealList
        bMealViewModel.mealList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                DispatchQueue.main.async {
                    hideLoading()
                    self.mealListData.removeAll()
                    self.mealListData = response.data?.data ?? []
                    self.mealBatchCollView.reloadData()
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
    
    func getTopRatedMealList() {
        DispatchQueue.main.async {
            showLoading()
        }
        let bMealViewModel = BMealViewModel()
        let urlStr = API.topRatedMealList
        bMealViewModel.mealList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                DispatchQueue.main.async {
                    hideLoading()
                    self.topRatedMealListData.removeAll()
                    self.topRatedMealListData = response.data?.data ?? []
                    self.topRatedMealCollView.reloadData()
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

extension BatchBoardHomeVC {
    func showImagesOnSrollView(array_Images : [String]){
        bannerSliderShow.slideshowInterval = 0
        bannerSliderShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .bottom)

        bannerSliderShow.contentScaleMode = .scaleAspectFill
        bannerSliderShow.scrollView.isPagingEnabled = true
        bannerSliderShow.circular = true
        bannerSliderShow.activityIndicator = DefaultActivityIndicator(style: .medium, color: nil)
        bannerSliderShow.scrollView.backgroundColor = UIColor(red: 225 / 255.0,green: 225 / 255.0,blue: 225 / 255.0,alpha: CGFloat(1.0))
        bannerSliderShow.activityIndicator = DefaultActivityIndicator()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        bannerSliderShow.addGestureRecognizer(gestureRecognizer)
        
//        let pageControl = UIPageControl()
//        pageControl.currentPageIndicatorTintColor = UIColor.black
//        pageControl.pageIndicatorTintColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.6)
//        pageControl.isEnabled = true
//        bannerSliderShow.pageIndicator = pageControl
        //        bannerSliderShow.pageIndicator = LabelPageIndicator()  ////it will show like 1/8,2/8,....
        
        //        var arr = [KingfisherSource]()
        //        for indx in 0 ..< array_Images.count {
        //            arr.append(KingfisherSource(urlString: array_Images[indx])!)
        //        }
        //        self.bannerSliderShow.setImageInputs(arr)
        
        bannerSliderShow.setImageInputs([
            ImageSource(image: UIImage(named: array_Images[0]) ?? UIImage()),
            ImageSource(image: UIImage(named: array_Images[1]) ?? UIImage()),
            ImageSource(image: UIImage(named: array_Images[2]) ?? UIImage()),
        ])
    }
    
    @objc func didTap() {
        bannerSliderShow.presentFullScreenController(from: self)
    }
}
