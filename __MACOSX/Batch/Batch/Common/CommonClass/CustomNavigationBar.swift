//
//  CustomNavigationBar.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 17/12/23.
//

import UIKit
import SDWebImage

@objc protocol barButtonTappedDelegate {
    @objc optional func leftBarButtonTapped()
    @objc optional func rightFirstBarBtnItem()
    @objc optional func rightSecondBarBtnItem()
    @objc optional func rightThirdBarBtnItem()
}

class CustomNavigationBar: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var leftBarBtnItem: UIButton!
    @IBOutlet weak var titleFirstLbl: BatchLabelTitleBlack!
    @IBOutlet weak var titleSecondLbl: UILabel!
    @IBOutlet weak var rightFirstBarBtnItem: UIButton!
    @IBOutlet weak var rightSecondBarBtnItem: UIButton!
    @IBOutlet weak var rightThirdBarBtnItem: UIButton!
    @IBOutlet weak var navFirstBackView: UIView!
    @IBOutlet weak var navSecondBackView: UIView!
    
    // MARK: - Properties
    var view : UIView?
    var leftBarButtonTappedDelegate : barButtonTappedDelegate?
    
    func xibSetup() {
        view = loadViewFromNib()
        view!.frame = bounds
        view!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view!)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomNavigationBar", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        titleFirstLbl.font = FontSize.mediumSize24
        let getprofilePhoto = Batch_UserDefaults.value(forKey: UserDefaultKey.profilePhoto) as? Data
        if getprofilePhoto != nil {
            profileImage.image = UIImage(data: getprofilePhoto ?? Data())
            profileImage.cornerRadius = 12
            profileImage.clipsToBounds = true
        }else{
            profileImage.image = UIImage(named: "Avatar")
            profileImage.cornerRadius = 0
        }
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func hideLeftBarButtonItem() {
        leftBarBtnItem.isHidden = true
    }
    
    //MARK: UIButton Action Methods
    
    @IBAction func leftBarBtnTapped(_ sender: Any) {
  
        if leftBarButtonTappedDelegate != nil {
            leftBarButtonTappedDelegate?.leftBarButtonTapped!()
        } else {
            let controller = (self.superview)?.next as! UIViewController
            _ = controller.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func rightBarBtnItem(_ sender: UIButton) {
        if sender == rightThirdBarBtnItem {
            if (UserDefaultUtility.isUserLoggedIn()) {
                let vc = BUserProfileVC.instantiate(fromAppStoryboard: .batchAccount)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                let controller = (self.superview)?.next as! UIViewController
                controller.present(vc, animated: true)
            }else{
                let vc = BLogInVC.instantiate(fromAppStoryboard: .batchLogInSignUp)
                vc.modalPresentationStyle = .overFullScreen
                vc.modalTransitionStyle = .coverVertical
                let controller = (self.superview)?.next as! UIViewController
                controller.present(vc, animated: true)
            }
        }
        
    }
    
}


