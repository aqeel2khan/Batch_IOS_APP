//
//  BStartWorkOutDetailVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 18/01/24.
//

import UIKit
import SDWebImage

class BStartWorkOutDetailVC: UIViewController {
    
    @IBOutlet weak var courseImgView: UIImageView!
    
    @IBOutlet weak var trainingCollectionView: UICollectionView!
    @IBOutlet weak var trainingCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var woTitleLbl: UILabel!
    @IBOutlet weak var woDesLbl: BatchLabelRegular16DarkGray!
    @IBOutlet weak var coachPicImgView: UIImageView!
    @IBOutlet weak var coachNameLbl: BatchLabelMedium14DarkGray!
    
    var courseDurationExerciseArr = [CourseDurationExercise]()
    var courseDetail: CourseDetail!
    var todayWorkoutsInfo : TodayWorkoutsElement!
    
    var refreshControl: UIRefreshControl!
    var completion: (()->Void)? = nil
    var viemoVideoArr = [String]()
    var titleText = "Lower-Body Burn"
    var dayNumberText : String!
    var dayName : String = ""
    var dayDesc : String = ""

    
    var newArray = [String]()
    var newImage = [UIImage]()
    var isCommingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionView()
        let leftLayout = leftSideDataInColl()
        leftLayout.estimatedItemSize = CGSize(width: 140, height: 40)
        trainingCollectionView.collectionViewLayout = leftLayout
        if isCommingFrom == "StartWorkout" {
            self.setUpDetailStartWOData()
        } else {
            self.setUpDetailCellData()
        }
    }
    private func setUpDetailStartWOData() {
        woTitleLbl.text = dayName
        self.woDesLbl.text = dayDesc
        
        self.coachNameLbl.text = courseDetail?.coachDetail?.name ?? ""
        let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (courseDetail?.courseImage ?? ""))
        self.coachPicImgView.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
        self.courseImgView.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))

        
        self.newArray.append("\(String(describing: todayWorkoutsInfo.noOfExercise ?? 0)) Exercise")
        newImage.append(UIImage(named: "accessibility_Black")!)
        
        self.newArray.append("\(String(describing: todayWorkoutsInfo.calorieBurn ?? "0")) kcal")
        newImage.append(UIImage(named: "flash-black")!)
        
        self.newArray.append("\(String(describing: todayWorkoutsInfo.workoutTime ?? "0")) min")
        newImage.append(UIImage(named: "clock-circle-black")!)
        
    }
    private func setUpDetailCellData(){
        //woTitleLbl.text = titleText
        //self.woDesLbl.text = courseDetail?.description ?? ""
        woTitleLbl.text = todayWorkoutsInfo.dayName
        self.woDesLbl.text = todayWorkoutsInfo.description ?? ""
        self.coachNameLbl.text = courseDetail?.coachDetail?.name ?? ""
        let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (courseDetail?.courseImage ?? ""))
        self.coachPicImgView.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
        self.courseImgView.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))

        
        self.newArray.append("\(String(describing: todayWorkoutsInfo.noOfExercise ?? 0)) Exercise")
        newImage.append(UIImage(named: "accessibility_Black")!)
        
        self.newArray.append("\(String(describing: todayWorkoutsInfo.calorieBurn ?? "0")) kcal")
        newImage.append(UIImage(named: "flash-black")!)
        
        self.newArray.append("\(String(describing: todayWorkoutsInfo.workoutTime ?? "0")) min")
        newImage.append(UIImage(named: "clock-circle-black")!)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update height constraint
        self.trainingCollectionHeight.constant = self.trainingCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"
        {
            if let newValue = change?[.newKey] {
                let newsize = newValue as! CGSize
                self.trainingCollectionHeight.constant = newsize.height
            }
        }
    }
    func setUpCollectionView(){
        trainingCollectionView.register(UINib(nibName: "BatchTrainingDetailCollCell", bundle: .main), forCellWithReuseIdentifier: "BatchTrainingDetailCollCell")
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapStartWorkOutBtn(_ sender: UIButton) {
        let vc = VimoPlayerVC.instantiate(fromAppStoryboard: .batchTrainings)
        vc.courseDurationExerciseArr = self.courseDurationExerciseArr
        vc.courseDetail = courseDetail
        vc.viemoVideoArr = viemoVideoArr
        vc.todayWorkoutsInfo = todayWorkoutsInfo
        vc.dayNumberText = dayNumberText
        vc.titleText = titleText
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.completion = {
            
        }
        self.present(vc, animated: true)
        
        //        self.startWorkOutApi(courseId: self.courseDetailsInfo.courseID, workoutId: self.todayWorkoutsInfo.courseDurationID, workoutExerciseId: self.courseDurationExerciseArr[0].courseDurationExerciseID, exerciseStatus: "true")
    }
}

extension BStartWorkOutDetailVC {
    
    private func startWorkOutApi(courseId:String, workoutId:String, workoutExerciseId:String, exerciseStatus: String){
        
        let request = StartWorkOutRequset(courseID: courseId, workoutID: workoutId, workoutExerciseID: workoutExerciseId, exerciseStatus: exerciseStatus)
        DispatchQueue.main.async {
            showLoading()
        }
        let bStartWorkOutDetailViewModel = BStartWorkOutDetailViewModel()
        bStartWorkOutDetailViewModel.startWorkOut(request: request)  { (response) in
            
            if response.status == true  {
                
                DispatchQueue.main.async {
                    hideLoading()
                    let vc = VimoPlayerVC.instantiate(fromAppStoryboard: .batchTrainings)
                    vc.courseDurationExerciseArr = self.courseDurationExerciseArr
                    vc.courseDetail = self.courseDetail
                    vc.viemoVideoArr = self.viemoVideoArr
                    vc.todayWorkoutsInfo = self.todayWorkoutsInfo
                    vc.dayNumberText = self.dayNumberText
                    vc.titleText = self.titleText
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .coverVertical
                    vc.completion = {
                        
                    }
                    self.present(vc, animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.showAlert(message: "\(error.localizedDescription)")
            }
        }
    }
    
}



/*
 class BStartWorkOutDetailVC: UIViewController {
 
 @IBOutlet weak var trainingCollectionView: UICollectionView!
 @IBOutlet weak var trainingCollectionHeight: NSLayoutConstraint!
 
 /*
  var workOutArray = ["20 trainings","15-20 min","Beginner","Yoga","Stretching","Cardio"]
  var workOutIconArray = [#imageLiteral(resourceName: "accessibility_Black"), #imageLiteral(resourceName: "clock-circle-black"), #imageLiteral(resourceName: "barchart-black"), #imageLiteral(resourceName: "accessibility_Black"), #imageLiteral(resourceName: "accessibility_Black"), #imageLiteral(resourceName: "accessibility_Black")]
  */
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 /*
  setUpCollectionView()
  let leftLayout = leftSideDataInColl()
  leftLayout.estimatedItemSize = CGSize(width: 140, height: 40)
  trainingCollectionView.collectionViewLayout = leftLayout
  */
 }
 override func viewDidLayoutSubviews() {
 super.viewDidLayoutSubviews()
 /*
  // Update height constraint
  self.trainingCollectionHeight.constant = self.trainingCollectionView.collectionViewLayout.collectionViewContentSize.height
  */
 }
 /*
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
  if keyPath == "contentSize"
  {
  if let newValue = change?[.newKey] {
  let newsize = newValue as! CGSize
  self.trainingCollectionHeight.constant = newsize.height
  
  }
  }
  }
  */
 /*
  func setUpCollectionView(){
  trainingCollectionView.register(UINib(nibName: "BatchTrainingDetailCollCell", bundle: .main), forCellWithReuseIdentifier: "BatchTrainingDetailCollCell")
  }
  */
 @IBAction func onTapBackBtn(_ sender: Any) {
 dismiss(animated: true, completion: nil)
 }
 
 @IBAction func onTapStartWorkOutBtn(_ sender: UIButton) {
 //        let info = ""
 //        guard let courseId          = info else { return }
 //        guard let workoutId         = info else { return }
 //        guard let workoutExerciseId = info else { return }
 //        guard
 //            let exerciseStatus      = info else { return }
 //        self.startWorkOutApi(courseId: courseId, workoutId: workoutId, workoutExerciseId: workoutExerciseId, exerciseStatus: exerciseStatus)
 }
 }
 */


