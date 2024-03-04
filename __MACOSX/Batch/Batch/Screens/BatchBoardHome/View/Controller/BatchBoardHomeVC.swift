//
//  BatchBoardHomeVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import UIKit

class BatchBoardHomeVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet weak var pageControllCollView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var woBatchCollView: UICollectionView!
    @IBOutlet weak var motivatorsCollView: UICollectionView!
    @IBOutlet weak var mealBatchCollView: UICollectionView!
    @IBOutlet weak var topRatedMealCollView: UICollectionView!
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    var timer : Timer?
    var counter = 0
    //Slider Img Array
    let imgArr = ["image1","image2","image3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setupNavigationBar()
        self.registerCollView()
        self.setUpUI()
        
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
    
    // MARK: - UI
    
    private func setupNavigationBar() {
        customNavigationBar.titleFirstLbl.text = CustomNavTitle.batchBoardHomeVCNavTitle
    }
    private func setUpUI()
    {
        self.pageControl.numberOfPages = self.imgArr.count
        // Start automatic scrolling timer
        startAutomaticScrolling()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop the timer when the view controller is about to disappear
        // stopAutomaticScrolling()
    }
    
    private func startAutomaticScrolling() {
        // Set up a timer to scroll automatically
        /*
         timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
         */
        //        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil, repeats: true)
        
        pageControl.numberOfPages = imgArr.count
        pageControl.currentPage = 0
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    private func stopAutomaticScrolling() {
        // Invalidate the timer to stop automatic scrolling
        timer?.invalidate()
        timer = nil
    }
    
    @objc func changeImage() {
        
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.pageControllCollView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.pageControllCollView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageControl.currentPage = counter
            counter = 1
        }
        
    }
    
    @objc func scrollToNextPage() {
        /*
         // Calculate the next page index
         let nextPage = (pageControl.currentPage + 1) % self.imgArr.count
         // Scroll to the next page
         let indexPath = IndexPath(item: nextPage, section: 0)
         pageControllCollView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
         
         // Update the page control
         pageControl.currentPage = nextPage
         */
    }
    
    private func registerCollView(){
        
        self.pageControllCollView.register(BatchHomePageContCollViewCell.self)
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
