//
//  BCheckoutVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 21/01/24.
//

import UIKit

class BCheckoutVC: UIViewController {
    @IBOutlet weak var imgCourse: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var woPriceLbl: UILabel!
    @IBOutlet weak var workOutTypeBtn: UIButton!
    @IBOutlet weak var goalLblBtn: UIButton!
    @IBOutlet weak var courseLevelTypeLbl: UIButton!
    @IBOutlet weak var coachProfileImg: UIImageView!
    @IBOutlet weak var coachNameLbl: UILabel!
    @IBOutlet weak var selectedPaymentTypeLbl: BatchLabelSubTitleBlack!
    @IBOutlet weak var subTotalPriceLbl: BatchMediumBlack!
    @IBOutlet weak var promotionPriceLbl: BatchMediumBlack!
    @IBOutlet weak var totalPriceLbl: BatchMediumBlack!
    @IBOutlet weak var checkOutBtn: BatchButton!
    
    var promotionPriceValue = 0.0
    var selectedSubscriptionInfo = [CourseDataList]()
    var selectedMotivatorSubscriptionInfo:CourseDataList?
    
    var isCommingFrom = ""
    
    var transactionID : String!
    var courseID = 0
    var subtotal = 0
    var discount = 0
    var total = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isCommingFrom == "workoutbatches" {
            self.setUpViewData()
        }
        else  if isCommingFrom == "MotivatorDetailVC" {
            self.setUpViewMotivatorData()
        }
    }
    
    func setUpViewData() {
        let info = selectedSubscriptionInfo[0]
        self.lblTitle.text = "\(info.courseName ?? "")"
//        self.woPriceLbl.text = BatchConstant.fromPrefix + " \(CURRENCY) " +  "\(info.coursePrice ?? "")".removeDecimalValue()
        let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(info.coursePrice ?? "")".removeDecimalValue(), prefixFont: UIFont(name:"Outfit-Medium",size:12)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
        self.woPriceLbl.attributedText = attributedPriceString

        self.coachNameLbl.text = "\(info.coachDetail?.name ?? "")"
        self.courseLevelTypeLbl.setTitle("\(info.courseLevel?.levelName ?? "")", for: .normal)
        let workType = info.workoutType?[0].workoutdetail?.workoutType
        self.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
        let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info.courseImage ?? ""))
        self.imgCourse.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
        let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info.coachDetail?.profilePhotoPath ?? ""))
        self.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ))
        
        let subTotalPrice = "\(info.coursePrice ?? "")"
        var subTotalPriceIntValue = 0.0
        if subTotalPrice != "" {
            subTotalPriceIntValue = Double(subTotalPrice) ?? 0.0
        }
        let promotionPrice = promotionPriceValue
        let totalPrice = subTotalPriceIntValue - promotionPrice
        
        self.subTotalPriceLbl.text = "\(info.coursePrice ?? "")"
        self.promotionPriceLbl.text = "-\(promotionPrice)"
        self.totalPriceLbl.text = "\(totalPrice)"
    }
    
    func setUpViewMotivatorData() {
        let info = selectedMotivatorSubscriptionInfo
        self.lblTitle.text = "\(info?.courseName ?? "")"
//        self.woPriceLbl.text = BatchConstant.fromPrefix + " \(CURRENCY) " +  "\(info?.coursePrice ?? "")".removeDecimalValue()
        let attributedPriceString = NSAttributedString.attributedStringForPrice(prefix: BatchConstant.fromPrefix, value: " \(CURRENCY) \(info?.coursePrice ?? "")".removeDecimalValue(), prefixFont: UIFont(name:"Outfit-Medium",size:12)!, valueFont: UIFont(name:"Outfit-Medium",size:18)!)
        self.woPriceLbl.attributedText = attributedPriceString
        
        self.coachNameLbl.text = "\(info?.coachDetail?.name ?? "")"
        self.courseLevelTypeLbl.setTitle("\(info?.courseLevel?.levelName ?? "")", for: .normal)
        let workType = info?.workoutType?[0].workoutdetail?.workoutType
        self.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
        let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info?.courseImage ?? ""))
        self.imgCourse.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
        let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info?.coachDetail?.profilePhotoPath ?? ""))
        self.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
        
        let subTotalPrice = "\(info?.coursePrice ?? "")"
        var subTotalPriceIntValue = 0.0
        if subTotalPrice != "" {
            subTotalPriceIntValue = Double(subTotalPrice) ?? 0.0
        }
        let promotionPrice = promotionPriceValue
        let totalPrice = subTotalPriceIntValue - promotionPrice
        
        self.subTotalPriceLbl.text = "\(info?.coursePrice ?? "")"
        self.promotionPriceLbl.text = "-\(promotionPrice)"
        self.totalPriceLbl.text = "\(totalPrice)"
    }
    
    @IBAction func onTapPaymentMethodBtn(_ sender: Any) {
        
    }
    
    @IBAction func onTapCheckOutBtn(_ sender: Any) {
        if getTotalPrice() != nil {
            let vc = BPaymentGatewayPopUpVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
            vc.modalPresentationStyle = .pageSheet
            vc.modalTransitionStyle = .coverVertical
            //vc.promotionPriceValue = 0
            vc.totalOrderAmount = getTotalPrice()
            if isCommingFrom == "workoutbatches" {
                vc.selectedSubscriptionInfo = [selectedSubscriptionInfo[0]]
            }
            else if isCommingFrom == "MotivatorDetailVC" {
                vc.selectedMotivatorSubscriptionInfo = selectedMotivatorSubscriptionInfo
            }
            vc.isCommingFrom = isCommingFrom
            vc.completion = { (transactionID) in
                self.createOrderCheckOutApi(courseID: self.courseID, subtotal: self.subtotal, discount: 0, total: self.total, paymentType: "card", transactionID: transactionID, paymentStatus: "true")
            }
            self.present(vc, animated: true)
        }
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func getTotalPrice() -> String? {
        // Convert the date to a Unix timestamp
        if isCommingFrom == "workoutbatches" {
            let info = selectedSubscriptionInfo[0]
            let courseIDStr = info.courseID
            courseID = Int(courseIDStr ?? 0)
            
            let subD = Double(info.coursePrice ?? "0.0") ?? 0.0
            subtotal = Int(subD)
            
            discount = Int(promotionPriceValue)
            let totalPrice = subD - promotionPriceValue
            total = Int(totalPrice)
        } else if isCommingFrom == "MotivatorDetailVC" {
            let info = selectedMotivatorSubscriptionInfo
            courseID = Int(info?.courseID ?? 0)
            
            let subD = Double(info?.coursePrice ?? "0.0") ?? 0.0
            subtotal = Int(subD)
            
            discount = Int(promotionPriceValue)
            
            let totalPrice = subD - promotionPriceValue
            total = Int(totalPrice)
        }
        if courseID == 0 {
            return nil
        }
        return "\(total)"
    }
    
    private func createOrderCheckOutApi(courseID:Int, subtotal:Int, discount:Int, total:Int, paymentType:String, transactionID:String, paymentStatus:String){
        let request =  CreateCourseOrderRequest(courseID: courseID, subtotal: subtotal, discount: discount, total: total, paymentType: paymentType, transactionID: transactionID, paymentStatus: paymentStatus)
        
        DispatchQueue.main.async {
            showLoading()
        }
        
        let bCheckoutViewModel = BCheckoutViewModel()
        bCheckoutViewModel.createOrderCheckOut(request: request)  { (response) in
            if response.status == true {
                DispatchQueue.main.async {
                    hideLoading()
                    let vc = BThankyouPurchaseVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .coverVertical
                    self.present(vc, animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.showAlert(message: response.message ?? "Api issue")
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







