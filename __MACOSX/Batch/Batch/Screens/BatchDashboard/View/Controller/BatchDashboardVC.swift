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
    @IBOutlet weak var mealCardView: UIView!
    @IBOutlet weak var workoutBatchCollView: UICollectionView!
    @IBOutlet weak var workoutCardView: UIView!
    @IBOutlet weak var macroContainer: UIView!

    
    @IBOutlet weak var kcalContainerView: UIView!
    @IBOutlet weak var kcalLabelValueTitle: UILabel!
    @IBOutlet weak var kcalStaticTitle: UILabel!
    
    @IBOutlet weak var progressBar1: UIProgressView!
    @IBOutlet weak var progressBar2: UIProgressView!
    @IBOutlet weak var progressBar3: UIProgressView!

    @IBOutlet weak var lblProgressBar1: UILabel!
    @IBOutlet weak var lblProgressBar2: UILabel!
    @IBOutlet weak var lblProgressBar3: UILabel!
  
    //var courseList = [List]()
    var courseList = [DashboardWOList]()
    var pieValue: [Double] = [7.25, 7]
    var subscribedMealListData : [SubscribedMeals] = []
    weak var axisFormatDelegate: AxisValueFormatter?
    var isSleep = true
    var currentSleepData = ""
    
   
    var macroDetails : Macros?

    var datesForSleep: [String] = []
    var datesForEnergyBurned: [String] = []
    
    var energyBurned: [Double] = []{
        didSet{
            DispatchQueue.main.async{
                self.healthKitTableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
            }
        }
    }
    
    
    var sleepData: [Double] = [2.3,5.4,1.2,7.8,9.5,4.2,8.8]{
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
    
    var datesSleep: [String] = ["Mon","Sun","Sat","Fri","Thu","Wed","Tue"]{
        didSet{
            DispatchQueue.main.async{
                self.healthKitTableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            }
        }
    }
    
    var datesEnergy: [String] = []{
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
        
        if UserDefaultUtility.isUserLoggedIn() {
            macroContainer.isHidden = false
        } else {
            macroContainer.isHidden = true
        }
        let healthPermission = Batch_UserDefaults.value(forKey: UserDefaultKey.healthPermission) as? Bool
        if UserDefaultUtility.isUserLoggedIn() && healthPermission ?? false{
            healthKitConnectBtnHeight.constant = 0
            healthKitConnectBtn.isHidden = true
            healthKitLabelHeight.constant = 0
            healthKitLabel.isHidden = true
            tableViewHeight.constant = 960
            healthKitTableView.isHidden = false
            loginBtn.isHidden = true
            loginBtnHeight.constant = 0
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
        
        kcalContainerView.layer.cornerRadius = kcalContainerView.bounds.width / 2
        kcalContainerView.layer.masksToBounds = true
        
        // Add a border
        kcalContainerView.layer.borderWidth = 2.0 // You can adjust the border width as needed
        kcalContainerView.layer.borderColor = UIColor.hexStringToUIColor(hex: "#516634").cgColor // You can adjust the border color as needed
        
        if UserDefaultUtility.isUserLoggedIn() {
            // Call Api here
            self.getSubscribedMealList()
            self.getSubscribedCourseList()
        } else {
            self.workoutCardView.isHidden = false
            self.mealCardView.isHidden = false
            self.workoutBatchCollView.isHidden = true
            self.mealBatchCollView.isHidden = true
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
                
        customNavigationBar.titleFirstLbl.text = CustomNavTitle.dashboardVCNavTitle.localized
        if let userName = UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.USER_NAME) as? String {
            customNavigationBar.titleFirstLbl.text = userName
        }  
                
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
            if response.status == true, response.data?.list?.count ?? 0 >= 0 {
                self.courseList.removeAll()
                self.courseList = response.data?.list ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.workoutBatchCollView.isHidden = false
                    self.workoutCardView.isHidden = true
                    self.workoutBatchCollView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.workoutCardView.isHidden = false
                    self.workoutBatchCollView.isHidden = true
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
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
    
    @IBAction func mealCardViewButtonTapped(_ sender: UIButton) {
        let vc = BatchTabBarController.instantiate(fromAppStoryboard: .batchTabBar)
        vc.selectedIndex = 2
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            Batch_AppDelegate.window?.rootViewController = vc
        }
    }
    
    @IBAction func workoutCardViewButtonBtnTapped(_ sender: UIButton) {
        let vc = BatchTabBarController.instantiate(fromAppStoryboard: .batchTabBar)
        vc.selectedIndex = 1
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            Batch_AppDelegate.window?.rootViewController = vc
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
                        self.tableViewHeight.constant = 960
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
                self.datesEnergy.removeAll()
                let data = dat?.statistics()
                if data?.count ?? 0 > 0{
                    for i in stride(from: (data?.count ?? 0) - 1, to: (data?.count ?? 0) - 7, by: -1){
                        self.energyBurned.append(data?[i].sumQuantity()?.doubleValue(for: HKUnit(from: "" + BatchConstant.kcalSuffix)) ?? 0)
                        let date = data?[i].startDate
                        let finalDate = self.dateToString(date: date ?? Date())
                        self.datesEnergy.append(finalDate)
                    }
                }
                dispatchGroup.leave()
            }
        }
        
//        queue.async {
//            dispatchGroup.enter()
//            HealthManager.shared.retrieveSleepAnalysis { data in
//                self.sleepData.removeAll()
//                self.datesSleep.removeAll()
//                if data?.count ?? 0 > 0{
//                    for i in stride(from: 0, to: 3, by: 1){
//                        let difference = Calendar.current.dateComponents([.hour, .minute], from: data![i].endDate, to: data![i].startDate)
//                        if i == 0{
//                            let formattedString = String(format: "%02dh%02dm", difference.hour!, difference.minute!).replacingOccurrences(of: "-", with: "")
//                            self.currentSleepData = formattedString
//                        }
//                       
//                        let doubleData = Double(difference.hour! * 60 + (difference.minute ?? 0))
//                        self.sleepData.append(-doubleData)
//                        let finalDate = self.dateToString(date: data![i].startDate)
//                        self.datesSleep.append(finalDate)
//                    }
//                }
//                dispatchGroup.leave()
//            }
//        }
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
        dateFormatter.dateFormat = "EE"
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
            if response.status == true, response.data?.data?.count ?? 0 >= 0 {
                self.subscribedMealListData.removeAll()
                self.subscribedMealListData = response.data?.data ?? []
                
                DispatchQueue.main.async {
                    hideLoading()
                    if self.subscribedMealListData.count > 0 {
                        self.mealCardView.isHidden = true
                        self.mealBatchCollView.isHidden = false
                    } else {
                        self.mealCardView.isHidden = false
                        self.mealBatchCollView.isHidden = true
                    }
                                        
                    self.mealBatchCollView.reloadData()
                    if response.data?.recordsTotal ?? 0 > 0  {
                        self.getMacrosDetail()
                        self.macroContainer.isHidden = false
                    } else {
                        self.macroContainer.isHidden = true
                    }
                }
            } else {
                DispatchQueue.main.async {
                    hideLoading()
                    self.mealBatchCollView.isHidden = true
                    self.mealCardView.isHidden = false
                    self.macroContainer.isHidden = true
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.mealBatchCollView.reloadData()
                self.macroContainer.isHidden = true
            }
        }
    }
    
    private func showLoader() {
        DispatchQueue.main.async {
            showLoading()
        }
    }
    
    //Get Macros Detail
    private func getMacrosDetail(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bHomeViewModel = DashboardViewModel()
        let urlStr = API.macroDetail
        
        guard let subscribedId = self.subscribedMealListData[0].subscribedId else {
            return
        }
        
        guard let mealId = self.subscribedMealListData[0].id else {
            return
        }

        let request = MacroRequest(userId: "\(UserDefaultUtility().getUserId())", mealId: "\(mealId)", subscribedId: "\(subscribedId)")
        bHomeViewModel.getMacroList(urlStr: urlStr, request: request) { (response) in
            if response.status == true, response.data?.data != nil {
                self.macroDetails = response.data?.data
                DispatchQueue.main.async {
                    hideLoading()
                    // macroContainer
                    self.kcalLabelValueTitle.text = self.macroDetails?.calories
                    self.kcalStaticTitle.text = "kcal"
                    
                    if let _ = self.macroDetails?.protein {
                        self.progressBar1.progress = Float(self.macroDetails?.normalizedValues().protein ?? 0.0)
                        self.lblProgressBar1.text = "\(Float(self.macroDetails?.protein ?? 0.0))% Protein"
                    }
                    
                    if let _ = self.macroDetails?.carbs {
                        self.progressBar2.progress = Float(self.macroDetails?.normalizedValues().carbs ?? 0.0)
                        self.lblProgressBar2.text = "\(Float(self.macroDetails?.carbs ?? 0.0))% Carbs"

                    }
                    
                    if let _ = self.macroDetails?.fat {
                        self.progressBar3.progress = Float(self.macroDetails?.normalizedValues().fat ?? 0.0)
                        self.lblProgressBar3.text = "\(Float(self.macroDetails?.fat ?? 0.0))% Fat"
                    }
                }
            } else {
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

extension BatchDashboardVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
                self.axisFormatDelegate = self
                cell.cellView.isUserInteractionEnabled = false
                if indexPath.row == 1{
                    isSleep = true
                    cell.sleepLabel.isHidden = false
                    cell.typeLabel.textColor = .black
                    cell.typeIcon.tintColor = .black
                    cell.typeLabel.text = "Sleep"
                    cell.typeIcon.image = UIImage(systemName: "moon.fill")
                    cell.sleepLabel.text = self.currentSleepData
                    cell.sleepLabelHeight.constant = 34
                    cell.lineChartView.isHidden = true
                    cell.barChartView.isHidden = false
                    cell.pieChartView.isHidden = true
                    updateBarChart(barChartView: cell.barChartView)
                    
                }else if indexPath.row == 2{
                    isSleep = false
                    cell.sleepLabel.isHidden = true
                    cell.lineChartView.isHidden = false
                    cell.barChartView.isHidden = true
                    cell.pieChartView.isHidden = true
                    cell.typeLabel.textColor = .white
                    cell.typeIcon.tintColor = .white
                    cell.typeLabel.text = "Callories"
                    cell.typeIcon.image = UIImage(systemName: "bolt.fill")
                    cell.sleepLabelHeight.constant = 0
                    cell.cellView.backgroundColor = UIColor(named: "AppThemeButtonColor")
                    updateLineChartForCallories(lineChartView: cell.lineChartView)
                }else{
                    isSleep = false
                    cell.sleepLabel.isHidden = true
                    cell.lineChartView.isHidden = true
                    cell.barChartView.isHidden = true
                    cell.pieChartView.isHidden = false
                    cell.typeLabel.textColor = .black
                    cell.typeIcon.tintColor = .black
                    cell.typeLabel.text = "Water"
                    cell.typeIcon.image = UIImage(systemName: "drop.fill")
                    cell.sleepLabelHeight.constant = 0
                    cell.cellView.backgroundColor = UIColor(named: "AppThemeBackgroundColor")
                    updatePieChart(pieChartView: cell.pieChartView)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BatchHealthGraphVC.instantiate(fromAppStoryboard: .batchDashboard)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    func updateLineChartForCallories(lineChartView: LineChartView){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<(self.energyBurned.count ){
            let lineChart = ChartDataEntry(x: Double(i), y:Double(self.energyBurned[i]), data: datesEnergy)
            lineChartEntry.append(lineChart)
        }
        let l1 = LineChartDataSet(entries: lineChartEntry)
        l1.colors = [.white]
        l1.drawCirclesEnabled = true
        l1.lineWidth = 2
        l1.lineCapType = .round
        l1.circleColors = [.white]
        l1.circleRadius = 3
        
        
        let chartData = LineChartData(dataSet: l1)
        chartData.setDrawValues(false)
        
        lineChartView.data = chartData
    
        lineChartView.legend.enabled = false
    
        lineChartView.rightAxis.enabled = false
        lineChartView.leftAxis.enabled = false
        lineChartView.drawBordersEnabled = false
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = true
        lineChartView.xAxis.gridLineDashLengths = [10]
        lineChartView.xAxis.gridColor = .white
        lineChartView.extraRightOffset = 10
        lineChartView.extraLeftOffset = 10
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.labelTextColor = .white
        lineChartView.xAxis.labelFont = UIFont(name: "Outfit-regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.granularityEnabled = true
        lineChartView.xAxis.granularity = 1
        lineChartView.xAxis.forceLabelsEnabled = true
        let xAxisValue = lineChartView.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
    }
    
    func updateBarChart(barChartView: BarChartView){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<(self.sleepData.count ){
            let lineChart = BarChartDataEntry(x: Double(i), y:Double(self.sleepData[i]),data: datesSleep)
            lineChartEntry.append(lineChart)
        }
        let l1 = BarChartDataSet(entries: lineChartEntry)
        let col = UIColor.init(named: "AppThemeButtonColor") ?? UIColor.black
        l1.colors = [col]
        
        /**
         to make bar-chart bar rounded need to make changes in pod of Charts
         Find BarChartRenderer.swift
                and then find method open func drawDataSet
                    
                replace this code:-
                    context.fill(barRect)
                with the code :-
                    let bezierPath = UIBezierPath(roundedRect: barRect, cornerRadius: %YOUR_CORNER_RADIUS%)
                    context.addPath(bezierPath.cgPath)
                    context.drawPath(using: .fill)
         
            on the line 382
         **/
        
        
        let chartData = BarChartData(dataSet: l1)
        chartData.setDrawValues(false)
        chartData.barWidth = 0.2
        
        barChartView.data = chartData
    
        barChartView.legend.enabled = false
        barChartView.rightAxis.enabled = false
        barChartView.rightAxis.axisLineWidth = 0
        barChartView.rightAxis.gridLineWidth = 0
        barChartView.rightAxis.labelAlignment = .center
        barChartView.leftAxis.enabled = false
        barChartView.drawBordersEnabled = false
        barChartView.drawGridBackgroundEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.forceLabelsEnabled = false
        barChartView.xAxis.labelPosition = .bottom
        let xAxisValue = barChartView.xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        barChartView.fitScreen()
    }
    
    func updatePieChart(pieChartView: PieChartView){
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<(self.pieValue.count ){
            let lineChart = ChartDataEntry(x: Double(i), y:Double(self.pieValue[i] ))
            lineChartEntry.append(lineChart)
        }
        let l1 = PieChartDataSet(entries: lineChartEntry)
    
        let col = UIColor.init(named: "AppThemeButtonColor") ?? UIColor.black
        let col1 = UIColor.init(named: "AppThemeSelectionColor") ?? UIColor.black
        l1.colors = [col, col1]
        let chartData = PieChartData(dataSet: l1)
        chartData.setDrawValues(false)
        pieChartView.data = chartData
        pieChartView.maxAngle = 180
        pieChartView.rotationAngle = 180
        pieChartView.drawCenterTextEnabled = true
       
        let centerString = "1.25"
        let unitString = "\n Litres"
        let finalAttriString = NSMutableAttributedString(string: "")
        let myAttribute = [NSAttributedString.Key.font: UIFont(name: "Outfit-Medium", size: 24.0)!, NSAttributedString.Key.foregroundColor: col]
        let myAttrString = NSAttributedString(string: centerString, attributes: myAttribute)
        finalAttriString.append(myAttrString)

        let unitAttribute = [NSAttributedString.Key.font: UIFont(name: "Outfit-Regular", size: 14.0)!, NSAttributedString.Key.foregroundColor: col1]
        let unitAttrString = NSAttributedString(string: unitString, attributes: unitAttribute)
        finalAttriString.append(unitAttrString)
        
        pieChartView.centerAttributedText = finalAttriString
        pieChartView.centerTextOffset = CGPoint(x: 0, y: -60)
        pieChartView.holeRadiusPercent = 0.95
        pieChartView.holeColor = .clear
        pieChartView.transparentCircleRadiusPercent = 0
        pieChartView.legend.enabled = false
        pieChartView.chartDescription.enabled = false
        pieChartView.minOffset = 0
    
        pieChartView.legend.enabled = false
    }

    
    
    func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        if isSleep{
            return datesSleep[Int(value)]
        }else{
            if datesEnergy.count > 0 && value > 0{
                return datesEnergy[Int(value)]
            }
        }
        return ""
    }
}

