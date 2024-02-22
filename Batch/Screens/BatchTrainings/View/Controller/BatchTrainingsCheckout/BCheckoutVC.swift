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
    
    var isCommingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if isCommingFrom == "workoutbatches"
        {
            self.setUpViewData()
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
    @IBAction func onTapPaymentMethodBtn(_ sender: Any) {
    }
    @IBAction func onTapCheckOutBtn(_ sender: Any) {
        let vc = BThankyouPurchaseVC.instantiate(fromAppStoryboard: .batchTrainingsCheckout)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
