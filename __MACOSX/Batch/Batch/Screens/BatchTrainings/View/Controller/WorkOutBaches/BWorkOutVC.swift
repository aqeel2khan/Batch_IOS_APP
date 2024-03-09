//
//  BWorkOutVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 17/12/23.
//

import UIKit

class BWorkOutVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet weak var segmentControl: BatchSegmentedControl!
    @IBOutlet weak var woBatchesBackView: UIView!
    @IBOutlet weak var woMotivatorBackView: UIView!
    @IBOutlet weak var batchesMotivatorCollView: UICollectionView!
    @IBOutlet weak var bHeaderLbl: UILabel!
    @IBOutlet weak var woSearchTextField: UITextField!
    
    // MARK: - Properties
    private let cornerRadius: CGFloat = 24
    
    //var httpUtility = HttpUtility1.shared
    var motivatorListData = [WorkOutMotivator]()
    var courseListData = [CourseDataList]()
    var selectedIndex = 0
    
    var courseListDataArr = [CourseDataList]()
    var coachListDataArr = [CoachListData]()
    
    var workItemReference : DispatchWorkItem? = nil
    
    var levelArray      = [AllBatchLevelList]()
    
    var workOutFilterArray    = [AllWorkoutTypeList]()
    var levelFilterArray      = [AllBatchLevelList]()
    var goalFilterArray = [AllBatchGoalList]()
    
    var coachFilterArray : CoachDataList!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the delegate of the custom search text field to self
        self.woSearchTextField.delegate = self
        setupNavigationBar()
        setupViews()
        
        //        // Call Api func here
        //        self.getCourses()
        //        self.getAllBatchesLevel()
        //        self.getAllWOTypes()
        //        self.getAllBatchGoals()
        //        self.getAllCoachFilterList()
        if internetConnection.isConnectedToNetwork() == true {
            // Call Api here
            self.getCourses()
            self.getMotivators()
            self.getAllBatchesLevel()
            self.getAllWOTypes()
            self.getAllBatchGoals()
            self.getAllCoachFilterList()
        }
        else
        {
            self.showAlert(message: "Please check your internet", title: "Network issue")
        }
        
        // Inside the class or part of the code where you want to observe the notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleCustomNotification(_:)), name: .myCustomNotification, object: nil)
    }
    @objc func handleCustomNotification(_ notification: Notification) {
        if internetConnection.isConnectedToNetwork() == true {
            if selectedIndex == 1 {
                self.getMotivators()
            }
            else {
                self.getCourses()
            }
        }
        else
        {
            self.showAlert(message: "Please check your internet", title: "Network issue")
        }
    }
    // MARK: - UI
    
    private func setupNavigationBar() {
        customNavigationBar.titleFirstLbl.text = CustomNavTitle.bWorkOutVCNavTitle
        let getprofilePhoto = Batch_UserDefaults.value(forKey: UserDefaultKey.profilePhoto) as? Data
        if getprofilePhoto != nil{
            customNavigationBar.profileImage.image = UIImage(data: getprofilePhoto ?? Data())
        }else{
            customNavigationBar.profileImage.image = UIImage(named: "Avatar")
        }//CustomNavTitle.batchWorkOutVC
        registerCollectionView()
    }
    private func registerCollectionView(){
        self.batchesMotivatorCollView.register(BWOBatchesListCollCell.self)
        self.batchesMotivatorCollView.register(BWOMotivatorsListCollCell.self)
    }
    
    private func setupViews() {
        
        self.bHeaderLbl.text = SetConstantTitle.bWorkOutHeaderLblText
        self.bHeaderLbl.font = FontSize.mediumSize18
        self.bHeaderLbl.textColor = Colors.appLabelBlackColor
    }
    
    private func setupCornerRadius() {
        //        containerView.roundCorners([MaskedCorners.topLeft, MaskedCorners.topRight], radius: cornerRadius)
    }
    
    // MARK: - IBActions
    
    @IBAction func segmentControlValueChanged(_ sender: BatchSegmentedControl) {
        if sender.selectedSegmentIndex == 0
        {
            selectedIndex = 0
            self.woBatchesBackView.isHidden = false
            self.woMotivatorBackView.isHidden = true
            if internetConnection.isConnectedToNetwork() == true {
                self.getCourses()
            }
        }
        else
        {
            selectedIndex = 1
            self.woBatchesBackView.isHidden = true
            self.woMotivatorBackView.isHidden = false
            // Call Api Here
            if internetConnection.isConnectedToNetwork() == true {
                // Call Api here
                self.getMotivators()
                //self.getSearchedMotivators()
            }
            else
            {
                self.showAlert(message: "Please check your internet", title: "Network issue")
            }
        }
        //        DispatchQueue.main.async {
        //            // self.checkNetwork()
        //            //self.batchesMotivatorCollView.reloadData()
        //        }
    }
    
    @IBAction func onTapFilterBtn(_ sender: Any) {
        let vc = TrainingFilterVC.instantiate(fromAppStoryboard: .batchTrainings)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.workOutArray = self.workOutFilterArray
        vc.levelArray = self.levelFilterArray
        vc.goalArray = self.goalFilterArray
        vc.completion = { (wo,level,goal) in
            print("Coming back Course Filter Id")
            self.applyCourseFilterApi(woFStr: wo, levelFStr: level, goalFStr: goal)
        }
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapMotivatorFilterBtn(_ sender: Any) {
        let vc = MotivatorFilterVC.instantiate(fromAppStoryboard: .batchTrainings)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.workOutArray = self.coachFilterArray?.workouttypes ?? []
        vc.experienceArray = self.coachFilterArray.experiences
        vc.completion = { (a,b) in
            print("Coming back Motivator filter Id")
            self.applyMotivatorFilterApi(keywordStr: "", experienceStr: a, workoutStr: b)
        }
        self.present(vc, animated: true)
    }
    
    // MARK: - API Call
    
    //Get Course List
    private func getCourses(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bWorkOutViewModel = BWorkOutViewModel()
        let urlStr = API.courseList
        bWorkOutViewModel.courseList(requestUrl: urlStr)  { (response) in
            
            if response.status == true, response.data?.list?.count != 0
            {
                // print(response.data)
                // self.blogsArray = response.data!
                self.courseListDataArr = response.data?.list ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.batchesMotivatorCollView.reloadData()
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
    
    //Get Coach List
    private func getMotivators(){
        DispatchQueue.main.async {
            showLoading()
        }
        let bWorkOutViewModel = BWorkOutViewModel()
        let urlStr = API.coachList
        bWorkOutViewModel.coachList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data != nil{
                print(response.data)
                
                self.coachListDataArr = response.data ?? []
                
                DispatchQueue.main.async {
                    hideLoading()
                    self.batchesMotivatorCollView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    //  makeToast(response.message!)
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                // makeToast(error.localizedDescription)
            }
        }
    }
    
    private func getSearchedMotivators(){
    }
    
    // Custom function to handle API search
    func performSearch(query: String) {
        // Implement API call and handling logic here
        // You can make a network request, process the response, and update your UI accordingly
        
        print("Performing search for: \(query)")
        //self.coachListDataArr.removeAll()
        let request = SearchRequest(keyword: query)
        DispatchQueue.main.async {
            // showLoading()
        }
        let bWorkOutViewModel = BWorkOutViewModel()
        let urlStr = API.coachList
        bWorkOutViewModel.coachList(requestUrl: urlStr)  { (response) in
            if response.status == true, response.data != nil{
                print(response.data as Any)
                self.coachListDataArr = response.data ?? []
                DispatchQueue.main.async {
                    // hideLoading()
                    self.batchesMotivatorCollView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    //  makeToast(response.message!)
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                // makeToast(error.localizedDescription)
            }
        }
    }
    
    private func getAllBatchesLevel(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let trainingFilterViewModel = TrainingFilterViewModel()
        let urlStr = API.allBatchLevelList
        
        trainingFilterViewModel.allBatchLevel(requestUrl: urlStr)  { (response) in
            
            if response.status == true, response.data?.list?.count != 0 {
                //print(response.data)
                // self.blogsArray = response.data!
                
                self.levelFilterArray = response.data?.list ?? []
                
                DispatchQueue.main.async {
                    hideLoading()
                    // self.blogTableView.reloadData()
                    //                    self.collectionView2.reloadData()
                    
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
    
    //MARK: - Get Filter Data Api
    private func getAllWOTypes(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let trainingFilterViewModel = TrainingFilterViewModel()
        let urlStr = API.allWOTypeList
        
        trainingFilterViewModel.allWOType(requestUrl: urlStr)  { (response) in
            
            if response.status == true , response.data?.list?.count != 0 {
                //print(response.data)
                self.workOutFilterArray = response.data?.list ?? []
                
                DispatchQueue.main.async {
                    hideLoading()
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
    private func getAllBatchGoals(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let trainingFilterViewModel = TrainingFilterViewModel()
        let urlStr = API.allBatchGoalList
        
        trainingFilterViewModel.allBatchGoal(requestUrl: urlStr)  { (response) in
            
            if response.status == true {
                //print(response.data)
                self.goalFilterArray = response.data?.list ?? []
                
                DispatchQueue.main.async {
                    hideLoading()
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
    
    private func getAllCoachFilterList(){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let trainingFilterViewModel = TrainingFilterViewModel()
        let urlStr = API.allCoachFilterList
        
        trainingFilterViewModel.allCoachFilterList(requestUrl: urlStr)  { (response) in
            
            if response.status == true {
                //print(response.data)
                self.coachFilterArray = response.data
                
                DispatchQueue.main.async {
                    hideLoading()
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
}

extension BWorkOutVC
{
    // Course Filter API CAll
    
    private func applyCourseFilterApi(woFStr:String, levelFStr:String, goalFStr:String){
        
        let request = CourseFilterRequest(courseLevel: levelFStr, workoutTypeID: woFStr, goalID: goalFStr)
        
        DispatchQueue.main.async {
            showLoading()
        }
        
        let bWorkOutViewModel = BWorkOutViewModel()
        bWorkOutViewModel.applyCourseFilter(request: request)  { (response) in
            
            if response.status == true, response.data?.list?.count != 0
            {
                print(response.data)
                // self.blogsArray = response.data!
                self.courseListDataArr = response.data?.list ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.batchesMotivatorCollView.reloadData()
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
                self.showAlert(message: "\(error.localizedDescription)")
                // makeToast(error.localizedDescription)
            }
        }
    }
    
    // Course Filter API CAll
    
    private func applyMotivatorFilterApi(keywordStr:String, experienceStr:String, workoutStr:String){
        
        let request =  MotivatorFilterRequest(keyword: keywordStr, experience: experienceStr, workoutType: workoutStr)
        
        DispatchQueue.main.async {
            showLoading()
        }
        
        let bWorkOutViewModel = BWorkOutViewModel()
        bWorkOutViewModel.applyCoachFilter(request: request)  { (response) in
            //response.data?.list?.count != 0
            if response.status == true
            {
                print(response.data)
                
                self.coachListDataArr = response.data ?? []
                
                DispatchQueue.main.async {
                    hideLoading()
                    self.batchesMotivatorCollView.reloadData()
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
                self.showAlert(message: "\(error.localizedDescription)")
                // makeToast(error.localizedDescription)
            }
        }
    }
    
}
