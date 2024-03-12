//
//  MealBatchVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/12/23.
//

import UIKit
import DGCharts
import HealthKit


class BatchDashboardVC: UIViewController, AxisValueFormatter {
    
    
    @IBOutlet weak var loginBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var healthKitTableView: UITableView!
    @IBOutlet weak var loginBtn: BatchButton!
    @IBOutlet weak var healthKitConnectBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var healthKitConnectBtn: BatchButton!
    @IBOutlet weak var healthKitLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var healthKitLabel: BatchMediumDarkGray!
    @IBOutlet weak var healthConnectView: UIView!
    // MARK: - IBOutlets
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet weak var mealBatchCollView: UICollectionView!
    @IBOutlet weak var workoutBatchCollView: UICollectionView!
    @IBOutlet weak var macroContainer: UIView!

    //var courseList = [List]()
    var courseList = [DashboardWOList]()
    var subscribedMealListData : [SubscribedMeals] = []
    weak var axisFormatDelegate: AxisValueFormatter?
   
    var datesForSleep: [String] = []
    var datesForEnergyBurned: [String] = []
    
    var energyBurned: [Double] = []{
        didSet{
            DispatchQueue.main.async{
                self.healthKitTableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
            }
        }
    }
    
    
    var sleepData: [String] = []{
        didSet{
            DispatchQueue.main.async{
                self.healthKitTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            }
        }
    }
    
    var heartRate: Int?{
        didSet{
            DispatchQueue.main.async{
                self.healthKitTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        }
    }
    
    var stepCount: Int?{
        didSet{
            DispatchQueue.main.async{
                self.healthKitTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        }
    }
    
    var datesSleep: [String]?{
        didSet{
            DispatchQueue.main.async{
                self.healthKitTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            }
        }
    }
    
    var datesEnergy: [String]?{
        didSet{
            DispatchQueue.main.async{
                self.healthKitTableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
            }
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
        loginBtn.isHidden = true
        if !UserDefaultUtility.isUserLoggedIn() {
            loginBtn.isHidden = false
            let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
            vc.modalPresentationStyle = .overFullScreen
            vc.CallBackToUpdateProfile = {
                DispatchQueue.main.async {
                    self.viewWillAppear(true)
                }
            }
            vc.isCommingFrom = "BatchBoard"
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
        let healthPermission = Batch_UserDefaults.value(forKey: UserDefaultKey.healthPermission) as? Bool
        if UserDefaultUtility.isUserLoggedIn() && healthPermission ?? false{
            healthKitConnectBtnHeight.constant = 0
            healthKitConnectBtn.isHidden = true
            healthKitLabelHeight.constant = 0
            healthKitLabel.isHidden = true
            tableViewHeight.constant = 700
            healthKitTableView.isHidden = false
            loginBtn.isHidden = true
            loginBtnHeight.constant = 0
            self.axisFormatDelegate = self
            self.fetchHealthKitData()
        }else if  UserDefaultUtility.isUserLoggedIn() && !(healthPermission ?? false){
            healthKitConnectBtnHeight.constant = 56
            healthKitConnectBtn.isHidden = false
            healthKitLabelHeight.constant = 90
            healthKitLabel.isHidden = false
            tableViewHeight.constant = 0
            healthKitTableView.isHidden = true
            loginBtn.isHidden = true
            loginBtnHeight.constant = 0
        }else{
            healthKitConnectBtnHeight.constant = 56
            healthKitConnectBtn.isHidden = false
            healthKitLabelHeight.constant = 90
            healthKitLabel.isHidden = false
            tableViewHeight.constant = 0
            healthKitTableView.isHidden = true
            loginBtn.isHidden = false
            loginBtnHeight.constant = 56
        }
        
        if UserDefaultUtility.isUserLoggedIn() {
            if internetConnection.isConnectedToNetwork() == true {
                //self.workoutBatchCollView.isHidden = false
                // Call Api here
                self.getSubscribedMealList()
                self.getSubscribedCourseList()
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
    
  
    
    func updateLineChartForSleeping(){
//        var lineChartEntry = [ChartDataEntry]()
//        for i in 0..<self.sleepingData.count{
//            let lineChart = ChartDataEntry(x: Double(i), y:Double(i), data: dates)
//            lineChartEntry.append(lineChart)
//        }
//        let l1 = LineChartDataSet(entries: lineChartEntry)
//        l1.colors = [UIColor.white]
//        
//        let chartData = LineChartData(dataSet: l1)
//        sleepChartView.data = chartData
//        sleepChartView.legend.enabled = false
//        sleepChartView.rightAxis.enabled = false
//        sleepChartView.leftAxis.enabled = false
//        sleepChartView.drawBordersEnabled = false
//        sleepChartView.setDragOffsetX(22.0)
//        
//        sleepChartView.xAxis.labelPosition = .bottom
//        sleepChartView.xAxis.drawAxisLineEnabled = false
//        sleepChartView.xAxis.granularityEnabled = true
//        sleepChartView.xAxis.granularity = 1
//        sleepChartView.xAxis.forceLabelsEnabled = true
//        let xAxisValue = sleepChartView.xAxis
//        let formatter = NumberFormatter()
//        formatter.minimumFractionDigits = 2
//        chartData.setValueFormatter(DefaultValueFormatter(formatter:formatter))
//        xAxisValue.valueFormatter = axisFormatDelegate
    }
    
    
    private func setupNavigationBar() {
        customNavigationBar.titleFirstLbl.text = CustomNavTitle.dashboardVCNavTitle
        let getprofilePhoto = Batch_UserDefaults.value(forKey: UserDefaultKey.profilePhoto) as? Data
        if getprofilePhoto != nil{
            customNavigationBar.profileImage.image = UIImage(data: getprofilePhoto ?? Data())
        }else{
            customNavigationBar.profileImage.image = UIImage(named: "Avatar")
        }
        self.registerCollTblView()
    }
    
    private func registerCollTblView(){
        healthKitTableView.register(UINib(nibName: "HSCell", bundle: nil), forCellReuseIdentifier: "HSCell")
        healthKitTableView.register(UINib(nibName: "SleepHealthCell", bundle: nil), forCellReuseIdentifier: "SleepHealthCell")

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
    
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
        vc.modalPresentationStyle = .overFullScreen
        vc.isCommingFrom = "BatchBoard"
        vc.CallBackToUpdateProfile = {
            DispatchQueue.main.async {
                self.viewWillAppear(true)
            }
        }
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
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
                        self.tableViewHeight.constant = 0
                        self.healthKitTableView.isHidden = true
                        self.showAlert(message: err ?? "")
                    }
                }else{
                    Batch_UserDefaults.set(true , forKey: UserDefaultKey.healthPermission)
                    DispatchQueue.main.async {
                        DispatchQueue.main.async {
                            showLoading()
                        }
                        self.fetchHealthKitData()
                        self.healthKitConnectBtnHeight.constant = 0
                        self.healthKitConnectBtn.isHidden = true
                        self.healthKitLabelHeight.constant = 0
                        self.healthKitLabel.isHidden = true
                        self.tableViewHeight.constant = 700
                        self.healthKitTableView.isHidden = false
                    }
                }
            }

        }else{
            let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
            vc.modalPresentationStyle = .overFullScreen
            vc.isCommingFrom = "BatchBoard"
            vc.CallBackToUpdateProfile = {
                DispatchQueue.main.async {
                    self.viewWillAppear(true)
                }
            }
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
    }
    
    
    func fetchHealthKitData(){
       
        let dispatchGroup = DispatchGroup()
       let queue = DispatchQueue(label: "healthKit data")
        queue.async {
            dispatchGroup.enter()
            HealthManager.shared.getTodaysSteps { steps in
                self.stepCount = Int(steps)
                dispatchGroup.leave()
            }
        }
        
        queue.async {
            dispatchGroup.enter()
            HealthManager.shared.getWeeklyEnergyBurned { dat in
                self.energyBurned.removeAll()
                self.datesEnergy?.removeAll()
                let data = dat?.statistics()
                if data?.count ?? 0 > 0{
                    for i in stride(from: (data?.count ?? 0) - 1, to: (data?.count ?? 0) - 7, by: -1){
                        self.energyBurned.append(data?[i].sumQuantity()?.doubleValue(for: HKUnit(from: "kcal")) ?? 0)
                        let date = data?[i].startDate
                        let finalDate = self.dateToString(date: date ?? Date())
                        self.datesEnergy?.append(finalDate)
                    }
                }
                dispatchGroup.leave()
            }
        }
        
        queue.async {
            dispatchGroup.enter()
            HealthManager.shared.retrieveSleepAnalysis { data in
                self.sleepData.removeAll()
                self.datesSleep?.removeAll()
                if data?.count ?? 0 > 0{
                    for i in stride(from: 0, to: 5, by: 1){
                        let difference = Calendar.current.dateComponents([.hour, .minute], from: data![i].endDate, to: data![i].startDate)
                        let formattedString = String(format: "%02dh%02dm", difference.hour!, difference.minute!).replacingOccurrences(of: "-", with: "")
                        self.sleepData.append(formattedString)
                        let finalDate = self.dateToString(date: data![i].startDate)
                        self.datesSleep?.append(finalDate)
                    }
                }
                dispatchGroup.leave()
            }
        }
        queue.async {
            dispatchGroup.enter()
            HealthManager.shared.fetchLatestHeartRateSample { samples in
              DispatchQueue.main.async {
                  if samples?.count ?? 0 > 0{
                      let heartRateInDouble = samples?.first?.quantity.doubleValue(for: HKUnit(from: "count/s"))
                      let heartRateInBPM = (heartRateInDouble ?? 0) * 60
                      self.heartRate = Int(heartRateInBPM)
                  }
                  dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                hideLoading()
            }
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
        DispatchQueue.main.async {
            self.showLoader()
        }
        
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
                    self.mealBatchCollView.isHidden = response.data?.data?.count == 0 ? true : false
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




extension BatchDashboardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HSCell", for: indexPath) as? HSCell{
                cell.heartRateLabel.text = "\(self.heartRate ?? 0)"
                cell.stepsLbl.text = "\(self.stepCount ?? 0)"
                return cell
            }
        }else{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SleepHealthCell", for: indexPath) as? SleepHealthCell{
                if indexPath.row == 1{
                    cell.sleepLabel.isHidden = false
                    cell.typeLabel.text = "Sleep"
                    cell.typeIcon.image = UIImage(systemName: "moon.fill")
                    cell.sleepLabel.text = self.sleepData.first ?? ""
                    cell.cellView.backgroundColor = .gray
                    cell.sleepLabelHeight.constant = 34
                    
                }else{
                    cell.sleepLabel.isHidden = true
                    cell.typeLabel.text = "Callories"
                    cell.typeIcon.image = UIImage(systemName: "bolt.fill")
                    cell.cellView.backgroundColor = UIColor(named: "AppThemeButtonColor")
                    cell.sleepLabelHeight.constant = 0
                    updateLineChartForCallories(lineChartView: cell.lineChartView)
                }
               
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row ==  0{
            return 200
        }else{
            return 240
        }
    }
    
    func updateLineChartForCallories(lineChartView: LineChartView){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<(self.energyBurned.count ?? 0){
            let lineChart = ChartDataEntry(x: Double(i), y:Double(self.energyBurned[i] ?? 0), data: datesEnergy)
            lineChartEntry.append(lineChart)
        }
        let l1 = LineChartDataSet(entries: lineChartEntry)
        l1.colors = [UIColor.white]

        let chartData = LineChartData(dataSet: l1)
        lineChartView.data = chartData
        lineChartView.legend.enabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.drawBordersEnabled = false
        lineChartView.setDragOffsetX(22.0)

        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.granularityEnabled = true
        lineChartView.xAxis.granularity = 1
        lineChartView.xAxis.forceLabelsEnabled = true
        let xAxisValue = lineChartView.xAxis
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        chartData.setValueFormatter(DefaultValueFormatter(formatter:formatter))
        xAxisValue.valueFormatter = axisFormatDelegate
    }
    
    func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        if datesEnergy?.count ?? 0 > 0{
            return datesEnergy![Int(value)]
        }else{
            return ""
        }
       
    }
}

