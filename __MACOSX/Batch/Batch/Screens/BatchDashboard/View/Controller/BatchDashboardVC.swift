//
//  MealBatchVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import UIKit
import HealthKitUI

class BatchDashboardVC: UIViewController {
    
    @IBOutlet weak var sleepTimeLbl: UILabel!
    @IBOutlet weak var noSleepDataAvailableLbl: UILabel!
    @IBOutlet weak var noHealthDataLbl: UILabel!
    @IBOutlet weak var stepsCountLbl: UILabel!
    @IBOutlet weak var heartRateLabel: UILabel!
    @IBOutlet weak var healthDataStackHeight: NSLayoutConstraint!
    @IBOutlet weak var healthDataStack: UIStackView!
    @IBOutlet weak var healthKitConnectBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var healthKitConnectBtn: BatchButton!
    @IBOutlet weak var healthKitLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var healthKitLabel: BatchMediumDarkGray!
    @IBOutlet weak var healthConnectView: UIView!
    // MARK: - IBOutlets
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet weak var mealBatchCollView: UICollectionView!
    @IBOutlet weak var workoutBatchCollView: UICollectionView!
    //var courseList = [List]()
    var courseList = [DashboardWOList]()
    var subscribedMealListData : [SubscribedMeals] = []
    var calloriesBurned: [CalloriesBurned] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !UserDefaultUtility.isUserLoggedIn() {
            let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
        
        if UserDefaultUtility.isUserLoggedIn() && HealthManager.shared.isHealthKitAuthorised(){
            healthKitConnectBtnHeight.constant = 0
            healthKitConnectBtn.isHidden = true
            healthKitLabelHeight.constant = 0
            healthKitLabel.isHidden = true
            healthDataStack.isHidden = false
            healthDataStackHeight.constant = 640
    
            HealthManager.shared.getWeeklyEnergyBurned { dat in
                dat?.statistics().forEach({ data in
                    self.calloriesBurned.append(CalloriesBurned(cal: data.sumQuantity()?.doubleValue(for: HKUnit(from: "kcal")) ?? 0, date: data.endDate))
                })
                debugPrint(self.calloriesBurned)
                
            }
            
            
            HealthManager.shared.getTodaysSteps { steps in
                DispatchQueue.main.async {
                    self.stepsCountLbl.text = "\(Int(steps))"
                }
            }
            HealthManager.shared.fetchLatestHeartRateSample { samples in
              DispatchQueue.main.async {
                  let heartRateInDouble = samples?.first?.quantity.doubleValue(for: HKUnit(from: "count/s"))
                  let heartRateInBPM = (heartRateInDouble ?? 0) * 60
                  self.heartRateLabel.text = "\(Int(heartRateInBPM))"
                }
            }
        }else{
            healthKitConnectBtnHeight.constant = 56
            healthKitConnectBtn.isHidden = false
            healthKitLabelHeight.constant = 90
            healthKitLabel.isHidden = false
            healthDataStack.isHidden = true
            healthDataStackHeight.constant = 0
        }
        
        if UserDefaultUtility.isUserLoggedIn() {
            if internetConnection.isConnectedToNetwork() == true {
                //self.workoutBatchCollView.isHidden = false
                // Call Api here
                self.getSubscribedCourseList()
                self.getSubscribedMealList()
            }
            else
            {
                self.showAlert(message: "Please check your internet", title: "Network issue")
            }
        }
        else
        {
            self.workoutBatchCollView.isHidden = true
        }
    }
    
    private func setupNavigationBar() {
        customNavigationBar.titleFirstLbl.text = CustomNavTitle.dashboardVCNavTitle
        self.registerCollTblView()
    }
    
    private func registerCollTblView(){
        
        mealBatchCollView.register(UINib(nibName: "MealBatchDashboardCollectionCell", bundle: .main), forCellWithReuseIdentifier: "MealBatchDashboardCollectionCell")
        workoutBatchCollView.register(UINib(nibName: "WorkoutBatchDashboardCollectionCell", bundle: .main), forCellWithReuseIdentifier: "WorkoutBatchDashboardCollectionCell")
    }
    
    private func getSubscribedCourseList(){
        DispatchQueue.main.async {
            showLoading()
        }
        let dashboardViewModel = DashboardViewModel()
        let urlStr = API.courseSubscribeList
        
        dashboardViewModel.allCourseSubscribeList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data?.list?.count != 0 {
                self.courseList.removeAll(
                )
                self.courseList = response.data?.list ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.workoutBatchCollView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    //makeToast(response.message!)
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                // makeToast(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func connectToHealthKit(_ sender: UIButton) {
        if UserDefaultUtility.isUserLoggedIn() {
            HealthManager.shared.requestHealthkitPermissions { succ, err in
                if err != nil{
                    DispatchQueue.main.async {
                        self.healthKitConnectBtnHeight.constant = 56
                        self.healthKitConnectBtn.isHidden = false
                        self.healthKitLabelHeight.constant = 90
                        self.healthKitLabel.isHidden = false
                        self.healthDataStack.isHidden = true
                        self.healthDataStackHeight.constant = 0
                        self.showAlert(message: err ?? "")
                    }
                }else{
                    DispatchQueue.main.async {
                        self.healthKitConnectBtnHeight.constant = 0
                        self.healthKitConnectBtn.isHidden = true
                        self.healthKitLabelHeight.constant = 0
                        self.healthKitLabel.isHidden = true
                        self.healthDataStack.isHidden = false
                        self.healthDataStackHeight.constant = 640
                        HealthManager.shared.getTodaysSteps { steps in
                            DispatchQueue.main.async {
                                self.stepsCountLbl.text = "\(Int(steps))"
                            }
                        }
                        
                        HealthManager.shared.fetchLatestHeartRateSample { samples in
                          DispatchQueue.main.async {
                              let heartRateInDouble = samples?.first?.quantity.doubleValue(for: HKUnit(from: "count/s"))
                              let heartRateInBPM = (heartRateInDouble ?? 0) * 60
                              self.heartRateLabel.text = "\(Int(heartRateInBPM))"
                            }
                        }
                    }
                }
            }

        }else{
            let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
    }
    
}

extension BatchDashboardVC {
    // Call API for getting subscribed meal list
    private func getSubscribedMealList() {
        showLoader()
        let bHomeViewModel = DashboardViewModel()
        let urlStr = API.subscriptionMealList
        var request = SubscribedMealListRequest(userId: "")
        if let userId = Batch_UserDefaults.value(forKey: UserDefaultKey.USER_ID) {
            request.userId = "\(userId)"
        }
        bHomeViewModel.getSubscribedMealList(urlStr: urlStr, request: request) { (response) in
            if response.status == true, response.data?.data?.count != 0 {
                self.subscribedMealListData = response.data?.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.mealBatchCollView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    hideLoading()
                    self.mealBatchCollView.reloadData()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.mealBatchCollView.reloadData()
            }
        }
    }
    
    private func showLoader() {
        DispatchQueue.main.async {
            showLoading()
        }
    }
}
