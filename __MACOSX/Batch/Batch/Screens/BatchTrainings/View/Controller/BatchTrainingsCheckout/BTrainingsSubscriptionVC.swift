//
//  BTrainingsSubscriptionVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 20/01/24.
//

import UIKit

class BTrainingsSubscriptionVC: UIViewController {
    
    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblTitle: BatchLabelTitleBlack!
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
    var selectedMotivatorSubscriptionInfo : CourseDataList?
    var courseId : Int!
    var discountValue : Double = 0.0
    
    var isCommingFrom = ""
    var totalOrderAmount : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewData()
        // Inside the class or part of the code where you want to observe the notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleCustomNotification(_:)), name: .myCustomNotification, object: nil)
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
    
    func setUpViewData() {
        if isCommingFrom == "dashboard" {
            let info = selectedMotivatorSubscriptionInfo
            self.lblTitle.text = "\(info?.courseName ?? "")"
//            self.woPriceLbl.text = BatchConstant.fromPrefix + " \(CURRENCY) " +  "\(info?.coursePrice ?? "")".removeDecimalValue()
            let coursePrice = "\(info?.coursePrice ?? "")"
            let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(coursePrice.removeDecimalValue())", prefixFont: UIFont(name:"Outfit-Medium",size:12)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
            self.woPriceLbl.attributedText = attributedPriceString
            
            self.coachNameLbl.text = "\(info?.coachDetail?.name ?? "")"
            self.grandTotalPriceLbl.text = "\(CURRENCY) " + "\(coursePrice.removeDecimalValue())"
            self.totalOrderAmount = info?.coursePrice
            self.courseLevelTypeLbl.setTitle("\(info?.courseLevel?.levelName ?? "")", for: .normal)
            let workType = info?.workoutType?[0].workoutdetail?.workoutType
            self.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
            let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info?.courseImage ?? ""))
            self.imgCourse.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info?.coachDetail?.profilePhotoPath ?? ""))
            self.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
            
            courseId = info?.courseID
        }
        else if isCommingFrom == "workoutbatches" {
            let info = selectedSubscriptionInfo[0]
            self.lblTitle.text = "\(info.courseName ?? "")"
//            self.woPriceLbl.text = BatchConstant.fromPrefix + " \(CURRENCY) " +  "\(info.coursePrice ?? "")".removeDecimalValue()
            
            let coursePrice = "\(info.coursePrice ?? "")"
            let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(coursePrice.removeDecimalValue())", prefixFont: UIFont(name:"Outfit-Medium",size:12)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
            self.woPriceLbl.attributedText = attributedPriceString
            
            self.coachNameLbl.text = "\(info.coachDetail?.name ?? "")"
            self.grandTotalPriceLbl.text = "\(CURRENCY) " + "\(coursePrice.removeDecimalValue())"
            self.totalOrderAmount = info.coursePrice
            self.courseLevelTypeLbl.setTitle("\(info.courseLevel?.levelName ?? "")", for: .normal)
            let workType = info.workoutType?[0].workoutdetail?.workoutType
            self.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
            let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info.courseImage ?? ""))
            self.imgCourse.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info.coachDetail?.profilePhotoPath ?? ""))
            self.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
            courseId = info.courseID
        }
        else if isCommingFrom == "MotivatorDetailVC" {
            let info = selectedMotivatorSubscriptionInfo
            self.lblTitle.text = "\(info?.courseName ?? "")"
//            self.woPriceLbl.text = BatchConstant.fromPrefix + " \(CURRENCY) " +  "\(info?.coursePrice ?? "")".removeDecimalValue()
            
            let coursePrice = "\(info?.coursePrice ?? "")"
            let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(coursePrice.removeDecimalValue())", prefixFont: UIFont(name:"Outfit-Medium",size:12)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
            self.woPriceLbl.attributedText = attributedPriceString
            
            self.coachNameLbl.text = "\(info?.coachDetail?.name ?? "")"
            self.grandTotalPriceLbl.text = "\(CURRENCY) " + "\(coursePrice.removeDecimalValue())"
            self.totalOrderAmount = info?.coursePrice
            self.courseLevelTypeLbl.setTitle("\(info?.courseLevel?.levelName ?? "")", for: .normal)
            let workType = info?.workoutType?[0].workoutdetail?.workoutType
            self.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
            let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info?.courseImage ?? ""))
            self.imgCourse.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
            let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info?.coachDetail?.profilePhotoPath ?? ""))
            self.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
            courseId = info?.courseID
        }
        
        self.addPromoBtn.isHidden = UserDefaultUtility.isUserLoggedIn() ? false : true
    }
    
    
    @IBAction func onTapSelectPlanDurationBtn(_ sender: Any) {
        let vc = BWOPlanDurationPopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapCheckOutBtn(_ sender: Any) {
        if selectedPlaneDurationLbl.text == "" {
            showAlert(message: "Please select plan duration".localized)
        }
        else {
           if UserDefaultUtility.isUserLoggedIn() {
               let vc = BCheckoutVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
               vc.modalPresentationStyle = .overFullScreen
               vc.modalTransitionStyle = .coverVertical
               vc.promotionPriceValue = discountValue
               if isCommingFrom == "workoutbatches" {
                   vc.selectedSubscriptionInfo = [selectedSubscriptionInfo[0]]
               }
               else if isCommingFrom == "MotivatorDetailVC" {
                   vc.selectedMotivatorSubscriptionInfo = selectedMotivatorSubscriptionInfo
               }
               vc.isCommingFrom = self.isCommingFrom
               self.present(vc, animated: true)
           }
            else {
               let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
                vc.promotionPriceValue = discountValue
               if isCommingFrom == "workoutbatches" {
                   vc.selectedSubscriptionInfo = [selectedSubscriptionInfo[0]]
               }
                vc.CallBackToUpdateProfile = {
                    self.viewWillAppear(true)
                }
               vc.isCommingFrom = isCommingFrom
               vc.modalPresentationStyle = .overFullScreen
               vc.modalTransitionStyle = .crossDissolve
               self.present(vc, animated: true)
           }
        }
    }
    
    @IBAction func onTapAddPromoCodeBtn(_ sender: Any) {
        let vc = BPromoCodePopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.courseId = courseId
        vc.completion = { (discount, message) in
            self.discountValue = Double(discount) ?? 0.0
//            self.showAlert(message: message)
        }
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
