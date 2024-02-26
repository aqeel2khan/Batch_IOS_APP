//
//  BTrainingsSubscriptionVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 20/01/24.
//

import UIKit

class BTrainingsSubscriptionVC: UIViewController {
    
    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var woPriceLbl: UILabel!
    @IBOutlet weak var coachProfileImg: UIImageView!
    @IBOutlet weak var coachNameLbl: UILabel!
    @IBOutlet weak var selectedPlaneDurationLbl: BatchLabelSubTitleBlack!
    
    @IBOutlet weak var grandTotalPriceBackView: UIView!
    @IBOutlet weak var grandTotalPriceLbl: BatchLabelTitleBlack!
    @IBOutlet weak var workOutTypeBtn: UIButton!
    @IBOutlet weak var goalLblBtn: UIButton!
    @IBOutlet weak var courseLevelTypeLbl: UIButton!
    @IBOutlet weak var checkOutBtn: BatchButton!
    @IBOutlet weak var addPromoBtn: BatchButton!
    
    var selectedSubscriptionInfo = [CourseDataList]()
//    var selectedMotivatorSubscriptionInfo : motivatorCoachListDataList?
    var selectedMotivatorSubscriptionInfo : CourseDataList?

    var isCommingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        if isCommingFrom == "workoutbatches"
//        {
//            self.setUpViewData()
//        }
      
            self.setUpViewData()
        
        // Inside the class or part of the code where you want to observe the notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleCustomNotification(_:)), name: .myCustomNotification, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @objc func handleCustomNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let value = userInfo["key"] as? String {
                print("Received notification with value: \(value)")
                selectedPlaneDurationLbl.text = value
                if selectedPlaneDurationLbl.text != ""
                {
                    selectedPlaneDurationLbl.isHidden = false
                }
            }
        }
    }
    
    
    func setUpViewData()
    {

        if isCommingFrom == "dashboard"
        {
            let info = selectedMotivatorSubscriptionInfo
            
            self.lblTitle.text = "\(info?.courseName ?? "")"
            self.woPriceLbl.text = "\(info?.coursePrice ?? "")"
            self.coachNameLbl.text = "\(info?.coachDetail?.name ?? "")"
            self.grandTotalPriceLbl.text = "\(info?.coursePrice ?? "")"
            self.courseLevelTypeLbl.setTitle("\(info?.courseLevel?.levelName ?? "")", for: .normal)
            let workType = info?.workoutType?[0].workoutdetail?.workoutType
            self.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
            let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info?.courseImage ?? ""))
            self.imgCourse.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info?.coachDetail?.profilePhotoPath ?? ""))
            self.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
        }
        else if isCommingFrom == "workoutbatches"
        {
            let info = selectedSubscriptionInfo[0]
            self.lblTitle.text = "\(info.courseName ?? "")"
            self.woPriceLbl.text = "\(info.coursePrice ?? "")"
            self.coachNameLbl.text = "\(info.coachDetail?.name ?? "")"
            self.grandTotalPriceLbl.text = "\(info.coursePrice ?? "")"
            self.courseLevelTypeLbl.setTitle("\(info.courseLevel?.levelName ?? "")", for: .normal)
            let workType = info.workoutType?[0].workoutdetail?.workoutType
            self.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
            let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info.courseImage ?? ""))
            self.imgCourse.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info.coachDetail?.profilePhotoPath ?? ""))
            self.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
        }
        else if isCommingFrom == "MotivatorDetailVC"
        {
            let info = selectedMotivatorSubscriptionInfo
            self.lblTitle.text = "\(info?.courseName ?? "")"
            self.woPriceLbl.text = "\(info?.coursePrice ?? "")"
            self.coachNameLbl.text = "\(info?.coachDetail?.name ?? "")"
            self.grandTotalPriceLbl.text = "\(info?.coursePrice ?? "")"
            self.courseLevelTypeLbl.setTitle("\(info?.courseLevel?.levelName ?? "")", for: .normal)
            let workType = info?.workoutType?[0].workoutdetail?.workoutType
            self.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
            let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info?.courseImage ?? ""))
            self.imgCourse.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info?.coachDetail?.profilePhotoPath ?? ""))
            self.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
        }
        
        if UserDefaultUtility.isUserLoggedIn()
        {
            self.addPromoBtn.isHidden = false
        }
        else
        {
            self.addPromoBtn.isHidden = true
        }
    }
    
    
    @IBAction func onTapSelectPlanDurationBtn(_ sender: Any) {
        let vc = BWOPlanDurationPopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapCheckOutBtn(_ sender: Any) {
        
        if selectedPlaneDurationLbl.text == ""
        {
            showAlert(message: "Please select plan duration")
        }
        else
        {
           if UserDefaultUtility.isUserLoggedIn()
            {
               let vc = BCheckoutVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
               vc.modalPresentationStyle = .overFullScreen
               vc.modalTransitionStyle = .coverVertical
               vc.promotionPriceValue = 0
               if isCommingFrom == "workoutbatches"
               {
                   vc.selectedSubscriptionInfo = [selectedSubscriptionInfo[0]]
               }
               else if isCommingFrom == "MotivatorDetailVC"
               {
                   vc.selectedMotivatorSubscriptionInfo = selectedMotivatorSubscriptionInfo
               }
               vc.isCommingFrom = isCommingFrom
               self.present(vc, animated: true)
           }
            else {
               let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
               vc.promotionPriceValue = 0
               if isCommingFrom == "workoutbatches"
               {
                   vc.selectedSubscriptionInfo = [selectedSubscriptionInfo[0]]
               }
               vc.isCommingFrom = isCommingFrom
               vc.modalPresentationStyle = .overFullScreen
               vc.modalTransitionStyle = .crossDissolve
               self.present(vc, animated: true)
               
           }
            /*
            let vc = BCheckoutVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical
            vc.promotionPriceValue = 0
            if isCommingFrom == "workoutbatches"
            {
                vc.selectedSubscriptionInfo = [selectedSubscriptionInfo[0]]
            }
            vc.isCommingFrom = isCommingFrom
            self.present(vc, animated: true)
             */
        }
    }
    
    @IBAction func onTapAddPromoCodeBtn(_ sender: Any) {
        let vc = BPromoCodePopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }    
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func OnTapBatchProSubscriptionBtn(_ sender: UIButton) {
    }
    
}


extension Notification.Name {
    static let myCustomNotification = Notification.Name("MyCustomNotification")
}
