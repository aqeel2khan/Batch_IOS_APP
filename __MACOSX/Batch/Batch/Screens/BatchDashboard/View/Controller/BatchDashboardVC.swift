//
//  MealBatchVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import UIKit
import DGCharts
import HealthKit

class BatchDashboardVC: UIViewController {
    
    @IBOutlet weak var sleepChartView: LineChartView!
    @IBOutlet weak var calloriesChartView: LineChartView!
    @IBOutlet weak var sleepTimeLbl: UILabel!
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
    var calloriesBurned: [Double] = []
    var sleepingData: [String] = []
    var dates: [String] = []
    var dates1: [String] = []
    weak var axisFormatDelegate: AxisValueFormatter?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        axisFormatDelegate = self
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
        let healthPermission = Batch_UserDefaults.value(forKey: UserDefaultKey.healthPermission) as? Bool
        if UserDefaultUtility.isUserLoggedIn() && healthPermission ?? false{
            healthKitConnectBtnHeight.constant = 0
            healthKitConnectBtn.isHidden = true
            healthKitLabelHeight.constant = 0
            healthKitLabel.isHidden = true
            healthDataStack.isHidden = false
            healthDataStackHeight.constant = 640
            
            HealthManager.shared.retrieveSleepAnalysis { data in
                if data?.count ?? 0 > 0{
                    self.dates.removeAll()
                    self.sleepingData.removeAll()
                    for i in stride(from: 0, to: 5, by: 1){
                        let difference = Calendar.current.dateComponents([.hour, .minute], from: data![i].endDate, to: data![i].startDate)
                        let formattedString = String(format: "%02dh%02dm", difference.hour!, difference.minute!).replacingOccurrences(of: "-", with: "")
                        self.sleepingData.append(formattedString)
                        let finalDate = self.dateToString(date: data![i].startDate)
                        self.dates.append(finalDate)
                    }
                    DispatchQueue.main.async{
                        self.sleepTimeLbl.isHidden = false
                        self.sleepTimeLbl.text = self.sleepingData.first
                    }
                }else{
                    DispatchQueue.main.async{
                        self.sleepTimeLbl.isHidden = true
                    }
                }
                
            }
    
            HealthManager.shared.getWeeklyEnergyBurned { dat in
                self.dates.removeAll()
                self.calloriesBurned.removeAll()
                let data = dat?.statistics()
                for i in stride(from: (data?.count ?? 0) - 1, to: (data?.count ?? 0) - 7, by: -1){
                    self.calloriesBurned.append(data?[i].sumQuantity()?.doubleValue(for: HKUnit(from: "kcal")) ?? 0)
                    let date = data?[i].startDate
                    let finalDate = self.dateToString(date: date ?? Date())
                    self.dates.append(finalDate)
                }
                DispatchQueue.main.async {
                    self.updateLineChartForCallories()
                }
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
    
    func updateLineChartForCallories(){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<self.calloriesBurned.count{
            let lineChart = ChartDataEntry(x: Double(i), y: self.calloriesBurned[i], data: dates)
            lineChartEntry.append(lineChart)
        }
        let l1 = LineChartDataSet(entries: lineChartEntry)
        l1.colors = [UIColor.white]
        
        let chartData = LineChartData(dataSet: l1)
        calloriesChartView.data = chartData
        calloriesChartView.legend.enabled = false
        calloriesChartView.rightAxis.enabled = false
        calloriesChartView.leftAxis.enabled = false
        calloriesChartView.drawBordersEnabled = false
        calloriesChartView.setDragOffsetX(22.0)
        
        calloriesChartView.xAxis.labelPosition = .bottom
        calloriesChartView.xAxis.drawAxisLineEnabled = false
        calloriesChartView.xAxis.granularityEnabled = true
        calloriesChartView.xAxis.granularity = 1
        calloriesChartView.xAxis.forceLabelsEnabled = true
        let xAxisValue = calloriesChartView.xAxis
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        chartData.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        xAxisValue.valueFormatter = axisFormatDelegate
    }
    
    func updateLineChartForSleeping(){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<self.sleepingData.count{
            let lineChart = ChartDataEntry(x: Double(i), y:Double(i), data: dates)
            lineChartEntry.append(lineChart)
        }
        let l1 = LineChartDataSet(entries: lineChartEntry)
        l1.colors = [UIColor.white]
        
        let chartData = LineChartData(dataSet: l1)
        sleepChartView.data = chartData
        sleepChartView.legend.enabled = false
        sleepChartView.rightAxis.enabled = false
        sleepChartView.leftAxis.enabled = false
        sleepChartView.drawBordersEnabled = false
        sleepChartView.setDragOffsetX(22.0)
        
        sleepChartView.xAxis.labelPosition = .bottom
        sleepChartView.xAxis.drawAxisLineEnabled = false
        sleepChartView.xAxis.granularityEnabled = true
        sleepChartView.xAxis.granularity = 1
        sleepChartView.xAxis.forceLabelsEnabled = true
        let xAxisValue = sleepChartView.xAxis
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        chartData.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        xAxisValue.valueFormatter = axisFormatDelegate
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
                    Batch_UserDefaults.set(false , forKey: UserDefaultKey.healthPermission)
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
                    Batch_UserDefaults.set(true , forKey: UserDefaultKey.healthPermission)
                    DispatchQueue.main.async {
                        self.healthKitConnectBtnHeight.constant = 0
                        self.healthKitConnectBtn.isHidden = true
                        self.healthKitLabelHeight.constant = 0
                        self.healthKitLabel.isHidden = true
                        self.healthDataStack.isHidden = false
                        self.healthDataStackHeight.constant = 640
                        
                        HealthManager.shared.retrieveSleepAnalysis { data in
                            if data?.count ?? 0 > 0{
                                self.dates.removeAll()
                                self.sleepingData.removeAll()
                                for i in stride(from: 0, to: 5, by: 1){
                                    let difference = Calendar.current.dateComponents([.hour, .minute], from: data![i].endDate, to: data![i].startDate)
                                    let formattedString = String(format: "%02dh%02dm", difference.hour!, difference.minute!).replacingOccurrences(of: "-", with: "")
                                    self.sleepingData.append(formattedString)
                                    let finalDate = self.dateToString(date: data![i].startDate)
                                    self.dates.append(finalDate)
                                }
                                DispatchQueue.main.async{
                                    self.sleepTimeLbl.isHidden = false
                                    self.sleepTimeLbl.text = self.sleepingData.first
                                }
                            }else{
                                DispatchQueue.main.async{
                                    self.sleepTimeLbl.isHidden = true
                                }
                            }
                            
                        }
                
                        HealthManager.shared.getWeeklyEnergyBurned { dat in
                            self.dates.removeAll()
                            self.calloriesBurned.removeAll()
                            let data = dat?.statistics()
                            for i in stride(from: (data?.count ?? 0) - 1, to: (data?.count ?? 0) - 7, by: -1){
                                self.calloriesBurned.append(data?[i].sumQuantity()?.doubleValue(for: HKUnit(from: "kcal")) ?? 0)
                                let date = data?[i].startDate
                                let finalDate = self.dateToString(date: date ?? Date())
                                self.dates.append(finalDate)
                            }
                            DispatchQueue.main.async {
                                self.updateLineChartForCallories()
                            }
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
    
    func dateToString(date: Date) -> String{
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "dd MMM yy"
        debugPrint(dateFormatter.string(from: date))
        // Convert Date to String
        return dateFormatter.string(from: date)
        
    }
    
    private func getSubscribedMealList() {
        showLoader()
        let bHomeViewModel = DashboardViewModel()
        let urlStr = API.subscriptionMealList
        let request = SubscribedMealListRequest(userId: "\(UserDefaultUtility().getUserId())")
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


extension BatchDashboardVC: AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return dates[Int(value)]
    }
}
