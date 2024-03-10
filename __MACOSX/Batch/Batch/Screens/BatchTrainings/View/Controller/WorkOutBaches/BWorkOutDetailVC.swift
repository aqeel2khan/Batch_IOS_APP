//
//  BWorkOutDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 17/12/23.
//

import UIKit
import HCVimeoVideoExtractor

class BWorkOutDetailVC: UIViewController {
    //Create a dispatch queue
    let dispatchQueue = DispatchQueue(label: "myQueue", qos: .background)
    //Create a semaphore
    let semaphore = DispatchSemaphore(value: 0)
    
    @IBOutlet weak var courseImgView: UIImageView!
    
    @IBOutlet weak var videoPlayBtn: UIButton!
    var coursePromotionVideoId = ""
    
    var vimoVideoIDArr = [String]()
    var vimoBaseUrl = "https://vimeo.com/"
    var videoURL: URL?
    var vimoVideoURLList = [String]()
    
    var newArray = [String]()
    var newImage = [UIImage]()
    
    // array use for add video url
    var courseDurationExerciseArr = [CourseDurationExercise]()
    
    @IBOutlet weak var woTitleLbl: UILabel!
    @IBOutlet weak var workOutPriceLbl: UILabel!
    @IBOutlet weak var woDesLbl: UILabel!
    @IBOutlet weak var coachPicImgView: UIImageView!
    @IBOutlet weak var coachNameLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var durationTitleLbl: UILabel!

    @IBOutlet weak var videoListTableHeight: NSLayoutConstraint!
    @IBOutlet weak var videoListTableView: UITableView!
    @IBOutlet weak var trainingCollectionView: UICollectionView!
    @IBOutlet weak var trainingCollectionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var grandTotalPriceBackView: UIView!
    @IBOutlet weak var subscribeCourseBtn: BatchButton!
    
    @IBOutlet weak var startWorkOutBtn: BatchButton!
    @IBOutlet weak var changeCourseBtn: BatchButton!
    
    @IBOutlet weak var grandTotalPriceLbl: BatchLabelTitleBlack!
    
    var isCommingFrom = ""
    
    var woDetailInfo = [CourseDataList]()
    var totalCourseArr = [CourseDurationWS]()
    var woMotivatorInfo:CourseDataList?
    
    
    var courseDetailsInfo : CourseDetail!
    var todayWorkoutsInfo : TodayWorkoutsElement!
    
    //var unsubscribeWorkoutsInfo : [WorkoutTypeWS]?
    var unsubscribeWorkoutsInfo = [TodayWorkoutsElement]()

    
    
    var totalCourseDashboardArr = [CourseDuration]()
    var videoIdArr = [String]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.videoListTableView.reloadData()
        self.videoListTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        callApiServices()
    }
    
    func callApiServices(){
        setUpCollectionView()
        let leftLayout = leftSideDataInColl()
        leftLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        trainingCollectionView.collectionViewLayout = leftLayout
        
        self.setUpViewData()
        
        if isCommingFrom == "workoutbatches"  {
            if woDetailInfo.count != 0 {
                let info = woDetailInfo[0]
                guard info.courseID != nil else { return }
                
                if internetConnection.isConnectedToNetwork() == true {
                    // Call Api here
                    self.getCourseDetails(courseId:"\(info.courseID ?? 0)")
                    //self.getCourseAllDurationList(courseId:"\(info.courseID ?? 0)")
                }
                else {
                    self.showAlert(message: "Please check your internet", title: "Network issue")
                }
                
            }
        } else if isCommingFrom == "dashboard" {
            let info = courseDetailsInfo
            guard info?.courseID != nil else { return }
            
            self.totalCourseDashboardArr = info?.courseDuration ?? []
            
            if info?.courseDuration?.count != 0 {
                
                self.videoIdArr.removeAll()
                
                
                self.courseDurationExerciseArr = todayWorkoutsInfo?.courseDurationExercise as? [CourseDurationExercise] ?? []

                for i in 0..<self.courseDurationExerciseArr.count {
                    let idArray = self.courseDurationExerciseArr
                    let videoId = idArray[i].videoDetail?.videoID ?? ""
                    print(idArray[i].videoDetail?.videoID ?? "")
                    self.videoIdArr.append(videoId)
                 
                }
              
            }
            self.videoListTableView.reloadData()
        }
    }
    
    func setUpViewData()  {
        
        if isCommingFrom == "MotivatorDetailVC"  {
            //self.workOutPriceLbl.isHidden = false
            self.grandTotalPriceBackView.isHidden = false
            self.subscribeCourseBtn.isHidden = false
            self.startWorkOutBtn.isHidden = true
            self.changeCourseBtn.isHidden = true
            
            let info = woMotivatorInfo
            self.woTitleLbl.text = info?.courseName
            self.workOutPriceLbl.text = "from \(CURRENCY) " + (info?.coursePrice?.removeDecimalValue() ?? "")
            self.woDesLbl.text = info?.description ?? ""
            self.coachNameLbl.text = info?.coachDetail?.name ?? ""
            self.durationLbl.text = info?.duration ?? ""
            let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info?.courseImage ?? ""))
            self.courseImgView.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info?.coachDetail?.profilePhotoPath ?? ""))
            self.coachPicImgView.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
            
            self.grandTotalPriceLbl.text = "\(CURRENCY) \(info?.coursePrice?.removeDecimalValue() ?? "")"
            
//            newArray.append("\(String(describing: info?.duration ?? "" )) min")
//            newImage.append(UIImage(named: "clock-circle-black")!)
            newArray.append("\(String(describing: info?.courseLevel?.levelName ?? "" ))")
            newImage.append(UIImage(named: "barchart-black")!)
            
            if info?.workoutType?.count != 0 {
                let workOutType = info?.workoutType?.count
                
                for i in 0..<(info?.workoutType!.count ?? 0) {
                    newArray.append("\(info?.workoutType?[i].workoutdetail?.workoutType ?? "" )")
                    newImage.append(UIImage(named: "accessibility_Black")!)
                }
            }
            
            durationTitleLbl.text = "Duration"
        }
        else if isCommingFrom == "workoutbatches" { // without subscription
            self.grandTotalPriceBackView.isHidden = false
            self.subscribeCourseBtn.isHidden = false
            self.startWorkOutBtn.isHidden = true
            self.changeCourseBtn.isHidden = true
            
            let info = woDetailInfo[0]
            self.woTitleLbl.text = info.courseName
            self.workOutPriceLbl.text = "from \(CURRENCY) " + (info.coursePrice?.removeDecimalValue() ?? "")
            self.woDesLbl.text = info.description ?? ""
            self.coachNameLbl.text = info.coachDetail?.name ?? ""
            self.durationLbl.text = info.duration ?? ""
            let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info.courseImage ?? ""))
            self.courseImgView.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info.coachDetail?.profilePhotoPath ?? ""))
            self.coachPicImgView.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
            
            self.grandTotalPriceLbl.text = "\(CURRENCY) \(info.coursePrice?.removeDecimalValue() ?? "")"
            
            self.coursePromotionVideoId = info.coursePromoVideo ?? ""
            self.videoPlayBtn.isHidden = false
            
            durationTitleLbl.text = "Duration"
        }
        else if isCommingFrom == "dashboard" {
            self.grandTotalPriceBackView.isHidden = true
            self.subscribeCourseBtn.isHidden = true
            self.startWorkOutBtn.isHidden = false
            self.changeCourseBtn.isHidden = false
            
            let info = courseDetailsInfo
            self.coursePromotionVideoId = info?.coursePromoVideo ?? ""
            self.woTitleLbl.text = info?.courseName
            self.workOutPriceLbl.text = "from \(CURRENCY) " + (info?.coursePrice?.removeDecimalValue() ?? "")
            self.woDesLbl.text = info?.description ?? ""
            self.coachNameLbl.text = info?.coachDetail?.name ?? ""
           
            self.durationLbl.text = "Day \(todayWorkoutsInfo.row ?? 0)"
           
            let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info?.courseImage ?? ""))
            self.courseImgView.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info?.coachDetail?.profilePhotoPath ?? ""))
            self.coachPicImgView.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
            
            self.grandTotalPriceLbl.text = "\(CURRENCY) \(info?.coursePrice?.removeDecimalValue() ?? "")"
            
            self.videoPlayBtn.isHidden = false
            
            durationTitleLbl.text = "Todays Exercise"
            
            // Enable user interaction for the UIImageView
            //            courseImgView.isUserInteractionEnabled = true
            
            //            // Add pan gesture to the UIImageView
            //            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(imagePanned(_:)))
            //            courseImgView.addGestureRecognizer(panGesture)
        }
        /*
         else
         {
         // self.workOutPriceLbl.isHidden = true
         self.grandTotalPriceBackView.isHidden = true
         self.subscribeCourseBtn.isHidden = true
         self.startWorkOutBtn.isHidden = false
         self.changeCourseBtn.isHidden = false
         
         let info = woDetailInfo[0]
         //            self.courseImgView: UIImageView!
         //            self.coachPicImgView: UIImageView!
         self.woTitleLbl.text = info.courseName
         self.workOutPriceLbl.text = info.coursePrice ?? ""
         self.woDesLbl.text = info.description ?? ""
         self.coachNameLbl.text = info.coachDetail?.name ?? ""
         self.durationLbl.text = info.duration ?? ""
         
         let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info.courseImage ?? ""))
         self.courseImgView.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
         
         let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info.coachDetail?.profilePhotoPath ?? ""))
         self.coachPicImgView.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
         
         }
         */
    }
    
    @IBAction func onTapVideoPlayBtn(_ sender: Any) {
        if coursePromotionVideoId != ""
        {
            let vc = VideoPlayerVC.instantiate(fromAppStoryboard: .batchTrainings)
            vc.courseVideoId = coursePromotionVideoId
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            self.present(vc, animated: true)
        }
        else
        {
            showAlert(message: "Promo video not available")
        }
    }
    //    @objc func imagePanned(_ gesture: UIPanGestureRecognizer) {
    //        let translation = gesture.translation(in: view)
    //
    //        switch gesture.state {
    //        case .began:
    //            // Save the original center of the UIImageView
    //            originalCenter = courseImgView.center
    //        case .changed:
    //            // Update the center based on the pan gesture's translation
    //            courseImgView.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
    //        case .ended, .cancelled:
    //            // Reset the original center or perform any other necessary actions
    //            originalCenter = nil
    //        default:
    //            break
    //        }
    //    }
    
    
    //MARK:- SetUp CollectionView
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //        self.videoListTableView.removeObserver(self, forKeyPath: "contentSize")
    //    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.videoListTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"
        {
            if let newValue = change?[.newKey] {
                let newsize = newValue as! CGSize
                self.videoListTableHeight.constant = newsize.height
            }
        }
        //        else{
        //            if keyPath == "contentSize"
        //            {
        //                if let newValue = change?[.newKey]
        //                {
        //                    let newsize = newValue as! CGSize
        //                    self.videoListTableHeight.constant = newsize.height
        //                }
        //            }
        //        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update height constraint
        self.trainingCollectionHeight.constant = self.trainingCollectionView.collectionViewLayout.collectionViewContentSize.height
        //        self.videoListTableHeight.constant = 10 * 130
        //self.videoListTableView.contentSize.height
        videoListTableView.reloadData()
        trainingCollectionView.reloadData()
        
        
    }
    
    
    func setUpCollectionView(){
        
        trainingCollectionView.delegate = self
        trainingCollectionView.dataSource = self
        
        videoListTableView.delegate = self
        videoListTableView.dataSource = self
        
        trainingCollectionView.register(UINib(nibName: "BatchTrainingDetailCollCell", bundle: .main), forCellWithReuseIdentifier: "BatchTrainingDetailCollCell")
        
        videoListTableView.register(UINib(nibName: "TrainingListTableCell", bundle: .main), forCellReuseIdentifier: "TrainingListTableCell")
        
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        // This post notification use for call api or perform any other things in previous screen
        let notification = Notification(name: .myCustomNotification, object: nil, userInfo: nil)
        NotificationCenter.default.post(notification)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTapStartWorkOutBtn(_ sender: UIButton) {
        vimoVideoSetUp {
            hideLoading()
            print("all video setup done")
            
            let vimeoVideoArr = self.videoIdArr.filter {$0 != ""}
            if vimeoVideoArr.count != 0 {
                let vc = VimoPlayerVC.instantiate(fromAppStoryboard: .batchTrainings)
                vc.courseDurationExerciseArr = self.courseDurationExerciseArr
                vc.courseDetail = self.courseDetailsInfo
                vc.viemoVideoArr = self.vimoVideoURLList
                vc.todayWorkoutsInfo = self.todayWorkoutsInfo

                vc.dayNumberText = "\(self.durationLbl.text ?? "") / \(self.totalCourseDashboardArr.count)"
                
                vc.titleText = self.woTitleLbl.text ?? ""
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                vc.completion = {
                    print(self.vimoVideoURLList)
                    self.callApiServices()
                    
                }
                self.present(vc, animated: true)
            }
            else {
                self.showAlert(message: "No exercise video availble")
            }
        }
    }
    
    @IBAction func onTapChangeCourseBtn(_ sender: UIButton) {
        let vc = BChangeCoursePopUpVC.instantiate(fromAppStoryboard: .batchTrainings)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapSusbscribeCourseBtn(_ sender: Any) {
        let vc = BTrainingsSubscriptionVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.isCommingFrom = isCommingFrom
        
        if isCommingFrom == "workoutbatches" {
            vc.selectedSubscriptionInfo = woDetailInfo
        }
        else if isCommingFrom == "MotivatorDetailVC" {
            vc.selectedMotivatorSubscriptionInfo = woMotivatorInfo
        }
        self.present(vc, animated: true)
    }
    
    private func getCourseDetails(courseId:String){
        DispatchQueue.main.async {
            showLoading()
        }
        let bWorkOutDetailViewModel = BWorkOutDetailViewModel()
        let urlStr = API.courseDetail + courseId
        bWorkOutDetailViewModel.courseDetail(requestUrl: urlStr)  { (response) in
            
            if response.status == true, response.data?.workouts?.count != 0 {
                print(response.data?.workouts?.count)
                self.unsubscribeWorkoutsInfo = response.data?.workouts ?? []
//                self.totalCourseArr = response.data?.courseDuration ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    self.videoListTableView.reloadData()
                }
            }
//            if response.status == true, response.data?.courseDuration?.count != 0 {
//                self.totalCourseArr = response.data?.courseDuration ?? []
//                // self.blogsArray = response.data!
//                DispatchQueue.main.async {
//                    hideLoading()
//                    self.videoListTableView.reloadData()
//                }
//            }
            else{
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
    
    private func getCourseAllDurationList(courseId:String){
        DispatchQueue.main.async {
            showLoading()
        }
        let bWOMotivatorDetailViewModel = BWorkOutMotivatorDetailViewModel()
        
        let urlStr = API.courseWOList + courseId
        bWOMotivatorDetailViewModel.coachDetailCourseList(requestUrl: urlStr)  { (response) in
            
            if response.status == true, response.data?.list?.count != 0 {
                DispatchQueue.main.async {
                    hideLoading()
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

//MARK: Extension for vimo Video

extension BWorkOutDetailVC {
    //MARK:- func play vimo video
    
    func vimoVideoSetUp(completion: @escaping ()->()) {
        showLoading()
        let farray = videoIdArr.filter {$0 != ""}
        if farray.count != 0 {
        vimoVideoURLList.removeAll()
            
            
            
            dispatchQueue.async {
                for i in 0..<(farray.count) {
                    if let url = URL(string: self.vimoBaseUrl + farray[i]) {
                        HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
                            
                            if let err = error {
                                completion()
                                
                                DispatchQueue.main.async() {
                                    self.videoURL = nil
                                    let alert = UIAlertController(title: "InCorrect VideoId", message: err.localizedDescription, preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                                return
                            }
                            guard let vid = video else {
                                print("Invalid video object")
                                completion()
                                return
                            }
                            
                            //  print("Title = \(vid.title), url = \(vid.videoURL), thumbnail = \(vid.thumbnailURL)")
                            
                            DispatchQueue.main.async() {
                                if let videoUrl = vid.videoURL[.quality1080p] {
                                    self.videoURL = videoUrl
                                } else if let videoUrl = vid.videoURL[.quality960p] {
                                    self.videoURL = videoUrl
                                } else if let videoUrl = vid.videoURL[.quality720p] {
                                    self.videoURL = videoUrl
                                } else if let videoUrl = vid.videoURL[.quality640p] {
                                    self.videoURL = videoUrl
                                } else if let videoUrl = vid.videoURL[.quality540p] {
                                    self.videoURL = videoUrl
                                } else if let videoUrl = vid.videoURL[.quality360p] {
                                    self.videoURL = videoUrl
                                } else if let videoUrl = vid.videoURL[.qualityUnknown] {
                                    self.videoURL = videoUrl
                                }
                                
                                guard let videoURL = self.videoURL else { return }
                                
                                self.videoURL = videoURL
                                if self.videoURL == nil {
                                    completion()
                                    self.showAlert(message: "Invalid Id")
                                    self.dismiss(animated: true)
                                }
                                else {
                                    self.vimoVideoURLList.append(self.videoURL!.absoluteString)
                                    if self.vimoVideoURLList.count == farray.count {
                                        completion()
                                    }
                                    // Signals that the 'current' API request has completed
                                    self.semaphore.signal()
                                }
                            }
                        })
                    }
                    // Wait until the previous API request completes
                    self.semaphore.wait()
                }
            }
        } else {
            completion()
        }
    }
    
}
