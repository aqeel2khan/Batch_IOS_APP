//
//  BWorkOutMotivatorDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 18/01/24.
//

import UIKit

class BWorkOutMotivatorDetailVC: UIViewController {
    
    @IBOutlet weak var followUnfollowBtn: UIButton!
    @IBOutlet weak var coachPicImgView: UIImageView!
    @IBOutlet weak var coachNameLbl: BatchMedium20Black!
    @IBOutlet weak var followerCountLbl: UILabel!
    @IBOutlet weak var desLbl: BatchLabelRegular16DarkGray!
    @IBOutlet weak var followBtn: BatchButton!
    @IBOutlet weak var unFollowBtn: BatchButton!
    @IBOutlet weak var trainingCollectionView: UICollectionView!
    @IBOutlet weak var trainingCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var traningPackageTblView: UITableView!
    @IBOutlet weak var traningPackageTblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var recomProductCollView: UICollectionView!
    @IBOutlet weak var recomProductCollViewHeight: NSLayoutConstraint!
    var workOutArray = ["20 trainings","15-20 min","Beginner","Yoga","Stretching","Cardio"]
    var workOutIconArray = [#imageLiteral(resourceName: "accessibility_Black"), #imageLiteral(resourceName: "clock-circle-black"), #imageLiteral(resourceName: "barchart-black"), #imageLiteral(resourceName: "accessibility_Black"), #imageLiteral(resourceName: "accessibility_Black"), #imageLiteral(resourceName: "accessibility_Black")]
    var recomProductArr = [#imageLiteral(resourceName: "Plans_Cards2"), #imageLiteral(resourceName: "Plans_Cards1"), #imageLiteral(resourceName: "Plans_Cards3"), #imageLiteral(resourceName: "Plans_Cards4"), #imageLiteral(resourceName: "Plans_Cards2"), #imageLiteral(resourceName: "Plans_Cards1"), #imageLiteral(resourceName: "Plans_Cards3"), #imageLiteral(resourceName: "Plans_Cards4")]
    
    var newArray = [String]()
    var newImage = [UIImage]()
    var woCoachDetailInfo = [CoachListData]()
    var coachDetailCourseArr = [CourseWorkoutList]()
    //    var motivatorCourseArr = [motivatorCoachListDataList]()
    var motivatorCourseArr = [CourseDataList]()
    
    var isFollowed = false
    var followerCount = 0
    
    // Set a time interval for debouncing (e.g., 1 second)
    let debounceInterval: TimeInterval = 0.50
    var isFollowButtonEnabled = true
    
    var isCommingFrom = ""
    var coachIdStr:String?
    var detailInfo: BCoachDetailResponseData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerCollectionTblView()
        self.addTags()
        
        if isCommingFrom == "BWorkOutDetailVC" {
            self.callCoachDetailApi()
        }
        else {
            self.setUpViewData()
        }
        self.callMotivatorCourseListApi()
    }
    
    func addTags()
    {
        // Add Tag
        let leftLayout = leftSideDataInColl()
        leftLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        trainingCollectionView.collectionViewLayout = leftLayout
    }
    
    func callMotivatorCourseListApi()
    {
        var coachIDD = "0"
        if isCommingFrom == "BWorkOutDetailVC" {
            coachIDD = self.coachIdStr ?? "0"
        }
        else {
            
            if woCoachDetailInfo.count != 0
            {
                let info = woCoachDetailInfo[0]
                coachIDD = "\(info.id ?? 0)"
                
                let isYouFollow = info.youFollowedCount
                if isYouFollow == 0
                {
                    self.isFollowed = false
                }
                else
                {
                    self.isFollowed = true
                }
            }
        }
        self.setMotivatorPrUI()
        
        //guard coachIDD != nil else { return }
        
        if internetConnection.isConnectedToNetwork() == true {
            // Call Api here
            if coachIDD != "0" {
                self.getMotivatorCourseList(coachId: coachIDD)
            }
        }
        else
        {
            self.showAlert(message: "Please check your internet", title: "Network issue")
        }
        
    }
    
    func callCoachDetailApi ()
    {
        if coachIdStr != "0"  {
            if internetConnection.isConnectedToNetwork() == true {
                self.getCoachDetails(coachId: "\(coachIdStr ?? "0")")
            }
            else
            {
                self.showAlert(message: "Please check your internet", title: "Network issue")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update height constraint
        self.trainingCollectionHeight.constant = self.trainingCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.traningPackageTblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.traningPackageTblView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"
        {
            if let newValue = change?[.newKey] {
                let newsize = newValue as! CGSize
                self.traningPackageTblViewHeight.constant = newsize.height
            }
        }
        
    }
    
    // MARK: - UI
    
    private func registerCollectionTblView(){
        /*
         self.traningPackageTblView.register(BWOBatchesListCollCell.self)
         self.recomProductCollView.register(BWOMotivatorsListCollCell.self)
         */
        trainingCollectionView.register(UINib(nibName: "BatchTrainingDetailCollCell", bundle: .main), forCellWithReuseIdentifier: "BatchTrainingDetailCollCell")
        traningPackageTblView.register(UINib(nibName: "BWOPackageTblCell", bundle: .main), forCellReuseIdentifier: "BWOPackageTblCell")
        recomProductCollView.register(UINib(nibName: "BWOMotivatorsReProductCollCell", bundle: .main), forCellWithReuseIdentifier: "BWOMotivatorsReProductCollCell")
    }
    
    func setMotivatorPrUI()
    {
        if UserDefaultUtility.isUserLoggedIn()
        {
            if self.isFollowed == false {
                self.followBtn.isHidden = true
                self.unFollowBtn.isHidden = false
                self.followUnfollowBtn.isHidden = false
            }
            else {
                self.followBtn.isHidden = false
                self.unFollowBtn.isHidden = true
                self.followUnfollowBtn.isHidden = false
            }
        }
        else
        {
            self.followBtn.isHidden = true
            self.unFollowBtn.isHidden = true
            self.followUnfollowBtn.isHidden = true
        }
    }
    
    func setUpViewData()
    {
        let info = woCoachDetailInfo[0]
        let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info.profilePhotoPath ?? ""))
        self.coachPicImgView.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
        self.coachNameLbl.text = "\(info.name ?? "")"
        self.followerCountLbl.text = "\(info.followersCount ?? 0) \(BatchConstant.followers)" //"0"
        self.followerCount = info.followersCount ?? 0
        self.desLbl.text = ""
        if info.workoutType?.count != 0 {
            for i in 0..<(info.workoutType!.count ?? 0) {
                newArray.append("\(info.workoutType?[i].workoutdetail?.workoutType ?? "" )")
                newImage.append(UIImage(named: "accessibility_Black")!)
            }
        }
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        // This post notification use for call api or perform any other things in previous screen
        let notification = Notification(name: .myCustomNotification, object: nil, userInfo: nil)
        NotificationCenter.default.post(notification)
        self.dismiss(animated: true)
    }
    
    @IBAction func onTapFollowUnfollowBtn(_ sender: UIButton) {
        
        // Check if the button is enabled
        guard isFollowButtonEnabled else {
            return
        }
        // Disable the button to prevent rapid clicks
        isFollowButtonEnabled = false
        
        sender.isSelected = self.isFollowed
        sender.isSelected = !sender.isSelected
        var fullUrlStr = ""
        var coachIDD = "0"
        if isCommingFrom == "BWorkOutDetailVC" {
            coachIDD = self.coachIdStr ?? "0"
        }
        else {
            if woCoachDetailInfo.count != 0
            {
                let info = woCoachDetailInfo[0]
                coachIDD = "\(info.id ?? 0)"
            }
        }
        //        guard info.id != nil else { return }
        if coachIDD != "0" {
            if internetConnection.isConnectedToNetwork() == true {
                // Call Api here
                if sender.isSelected
                {
                    self.followBtn.isHidden   = false
                    self.unFollowBtn.isHidden = true
                    self.followerCount += 1
                    self.followerCountLbl.text = "\(self.followerCount) \(BatchConstant.followers)"
                    fullUrlStr = API.motivatorFollow + coachIDD
                }
                else
                {
                    self.followBtn.isHidden   = true
                    self.unFollowBtn.isHidden = false
                    self.followerCount -= 1
                    self.followerCountLbl.text = "\(self.followerCount) \(BatchConstant.followers)"
                    fullUrlStr = API.motivatorUnfollow + coachIDD
                }
                
                self.getfollowUnfollow(urlStr: fullUrlStr)
            }
            else
            {
                self.showAlert(message: "Please check your internet", title: "Network issue")
            }
            
            // After the debounce interval, enable the button again
            DispatchQueue.main.asyncAfter(deadline: .now() + debounceInterval) { [weak self] in
                self?.isFollowButtonEnabled = true
            }
        }
    }
    
    //    @objc func cellBtnClicked(sender:UIButton)
    //    {
    //        let vc = BWorkOutDetailVC.instantiate(fromAppStoryboard: .batchTrainings)
    //        vc.isCommingFrom = "MotivatorDetailVC"
    //        vc.modalPresentationStyle = .overFullScreen
    //        vc.modalTransitionStyle = .coverVertical
    //        self.present(vc, animated: true)
    //    }
    
    
    private func setUpCoachProfileData() {
        
        let info = self.detailInfo
        let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info?.profilePhotoPath ?? ""))
        self.coachPicImgView.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
        self.coachNameLbl.text = "\(info?.name ?? "")"
        self.followerCountLbl.text = "\(info?.followersCount ?? 0) \(BatchConstant.followers)" //"0"
        self.followerCount = info?.followersCount ?? 0
        self.desLbl.text = ""
        
        let isYouFollow = info?.youFollowedCount
        if isYouFollow == 0
        {
            self.isFollowed = false
        }
        else
        {
            self.isFollowed = true
        }
        self.setMotivatorPrUI()
        
        if info?.workoutType?.count != 0 {
            for i in 0..<(info?.workoutType?.count ?? 0) {
                newArray.append("\(info?.workoutType?[i].workoutdetail?.workoutType ?? "" )")
                newImage.append(UIImage(named: "accessibility_Black")!)
            }
            self.trainingCollectionView.reloadData()

        }
    }
    private func getCoachDetails(coachId:String){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bWOMotivatorDetailViewModel = BWorkOutMotivatorDetailViewModel()
        let urlStr = API.coachDetail + coachId
        bWOMotivatorDetailViewModel.couchDetail(requestUrl: urlStr)  { (response) in
            
            if response.status == true {
                print(response.data)
                self.detailInfo = response.data
                DispatchQueue.main.async {
                    self.setUpCoachProfileData()
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
    
    private func getCoachDetailsCourseList(courseId:String){
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bWOMotivatorDetailViewModel = BWorkOutMotivatorDetailViewModel()
        
        let urlStr = API.courseWOList + courseId
        bWOMotivatorDetailViewModel.coachDetailCourseList(requestUrl: urlStr)  { (response) in
            
            //            if response.status == true, response.data?.count != 0{
            if response.status == true, response.data?.list?.count != 0 {
                
                self.coachDetailCourseArr = response.data?.list ?? []
                // self.blogsArray = response.data!
                
                DispatchQueue.main.async {
                    hideLoading()
                    self.traningPackageTblView.reloadData()
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
    
    private func getMotivatorCourseList(coachId:String){
        
        let request = motivatorCoachListRequest(coachID: coachId)
        
        DispatchQueue.main.async {
            showLoading()
        }
        let bWOMotivatorDetailViewModel = BWorkOutMotivatorDetailViewModel()
        
        bWOMotivatorDetailViewModel.motivatorCourseList(request: request) { (response) in
            
            if response.status == true, response.data?.list?.count != 0 {
                
                print(response.data)
                self.motivatorCourseArr = response.data?.list ?? []
                
                DispatchQueue.main.async {
                    hideLoading()
                    self.traningPackageTblView.reloadData()
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
    
    
    //    private func getMotivatorCourseList(coachId:String){
    //
    //
    //    DispatchQueue.main.async {
    //        showLoading()
    //    }
    //    let bWorkOutViewModel = BWorkOutViewModel()
    //    let urlStr = API.courseList
    //    bWorkOutViewModel.courseList(requestUrl: urlStr)  { (response) in
    //
    //        if response.status == true, response.data?.list?.count != 0
    //        {
    //            // print(response.data)
    //            // self.blogsArray = response.data!
    //            self.courseListDataArr = response.data?.list ?? []
    //            DispatchQueue.main.async {
    //                hideLoading()
    //                self.batchesMotivatorCollView.reloadData()
    //            }
    //        }else{
    //            DispatchQueue.main.async {
    //                hideLoading()
    //                //makeToast(response.message!)
    //            }
    //        }
    //
    //    } onError: { (error) in
    //        DispatchQueue.main.async {
    //            hideLoading()
    //            // makeToast(error.localizedDescription)
    //        }
    //    }
    //
    //}
    
    
    
    
    private func getfollowUnfollow(urlStr: String){
        //coachId:String,urlStr: String
        //let fullUrlStr = API.motivatorFollow + courseId
        
        DispatchQueue.main.async {
            // showLoading()
        }
        let bWOMotivatorDetailViewModel = BWorkOutMotivatorDetailViewModel()
        
        bWOMotivatorDetailViewModel.coachDetailCourseList(requestUrl: urlStr)  {
            (response) in
            
            if response.status == true, response.data?.list?.count != 0 {
                
                print(response.data as Any)
                ///self.motivatorCourseArr = response.data?.list ?? []
                
                DispatchQueue.main.async {
                    
                    if self.followBtn.isHidden == false
                    {
                        self.isFollowed = true
                        //self.followerCount += 1
                    }
                    else if self.unFollowBtn.isHidden == false
                    {
                        self.isFollowed = false
                    }
                    
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
