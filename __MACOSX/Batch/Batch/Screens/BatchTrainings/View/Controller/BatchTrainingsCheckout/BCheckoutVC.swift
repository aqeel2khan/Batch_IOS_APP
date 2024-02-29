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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if isCommingFrom == "workoutbatches"
        {
            self.setUpViewData()
        }
        else  if isCommingFrom == "MotivatorDetailVC"
        {
            self.setUpViewMotivatorData()
        }
    }
    
    func setUpViewData()
    {
        let info = selectedSubscriptionInfo[0]
        self.lblTitle.text = "\(info.courseName ?? "")"
        self.woPriceLbl.text = "\(info.coursePrice ?? "")"
        self.coachNameLbl.text = "\(info.coachDetail?.name ?? "")"
        self.courseLevelTypeLbl.setTitle("\(info.courseLevel?.levelName ?? "")", for: .normal)
        let workType = info.workoutType?[0].workoutdetail?.workoutType
        self.workOutTypeBtn.setTitle("\(workType ?? "")", for: .normal)
        let woImgUrl = URL(string: BaseUrl.imageBaseUrl + (info.courseImage ?? ""))
        self.imgCourse.sd_setImage(with: woImgUrl, placeholderImage:UIImage(named: "Image"))
        let profileUrl = URL(string: BaseUrl.imageBaseUrl + (info.coachDetail?.profilePhotoPath ?? ""))
        self.coachProfileImg.sd_setImage(with: profileUrl , placeholderImage:UIImage(named: "Avatar1" ) )
        
        let subTotalPrice = "\(info.coursePrice ?? "")"
        var subTotalPriceIntValue = 0.0
        if subTotalPrice != ""
        {
            subTotalPriceIntValue = Double(subTotalPrice) ?? 0.0
        }
        let promotionPrice = promotionPriceValue
        let totalPrice = subTotalPriceIntValue - promotionPrice
        
        self.subTotalPriceLbl.text = "\(info.coursePrice ?? "")"
        self.promotionPriceLbl.text = "-\(promotionPrice)"
        self.totalPriceLbl.text = "\(totalPrice)"
    }
    func setUpViewMotivatorData()
    {
        let info = selectedMotivatorSubscriptionInfo
        self.lblTitle.text = "\(info?.courseName ?? "")"
        self.woPriceLbl.text = "\(info?.coursePrice ?? "")"
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
        if subTotalPrice != ""
        {
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
        
        
        var courseID = 0
        var subtotal = 0
        var discount = 0
        var total = 0
        // Get the current date and time
        let currentDate = Date()
        // Convert the date to a Unix timestamp
        let timestamp = currentDate.timeIntervalSince1970
        print("Unix Timestamp: \(timestamp)")
        var transactionID = timestamp
        
        if isCommingFrom == "workoutbatches"
        {
            let info = selectedSubscriptionInfo[0]
            let courseIDStr = info.courseID
            courseID = Int(courseIDStr ?? 0)
            
            let subD = Double(info.coursePrice ?? "0.0") ?? 0.0
            subtotal = Int(subD)
            
            discount = Int(promotionPriceValue)
            
            let totalPrice = subD - promotionPriceValue
            total = Int(totalPrice)
            
            
        }
        else if isCommingFrom == "MotivatorDetailVC"
        {
            let info = selectedMotivatorSubscriptionInfo
            courseID = Int(info?.courseID ?? 0)
            
            let subD = Double(info?.coursePrice ?? "0.0") ?? 0.0
            subtotal = Int(subD)
            
            discount = Int(promotionPriceValue)
            
            let totalPrice = subD - promotionPriceValue
            total = Int(totalPrice)
            
        }
        if courseID == 0{
            return
        }
        self.createOrderCheckOutApi(courseID: courseID, subtotal: subtotal, discount: 0, total: total, paymentType: "card", transactionID: Int(transactionID), paymentStatus: "true")
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func createOrderCheckOutApi(courseID:Int, subtotal:Int, discount:Int, total:Int, paymentType:String, transactionID:Int, paymentStatus:String){
        
        let request =  CreateCourseOrderRequest(courseID: courseID, subtotal: subtotal, discount: discount, total: total, paymentType: paymentType, transactionID: transactionID, paymentStatus: paymentStatus)
        
        DispatchQueue.main.async {
            showLoading()
        }
        
        let bCheckoutViewModel = BCheckoutViewModel()
        bCheckoutViewModel.createOrderCheckOut(request: request)  { (response) in
            //response.data?.list?.count != 0
            if response.status == true
            {
                print(response.data)
                //                self.coachListDataArr = response.data ?? []
                DispatchQueue.main.async {
                    hideLoading()
                    //                    self.batchesMotivatorCollView.reloadData()
                    let vc = BThankyouPurchaseVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
                    vc.modalPresentationStyle = .overFullScreen
                    vc.modalTransitionStyle = .coverVertical
                    self.present(vc, animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    //makeToast(response.message!)
                    self.showAlert(message: response.message ?? "Api issue")
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







