//
//  CustomSecondNavigationBar.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 29/01/24.
//

import UIKit

@objc protocol secondBarButtonTappedDelegate {
    @objc optional func leftBarButtonTapped()
}

class CustomSecondNavigationBar: UIView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var leftBarBtnItem: UIButton!
    @IBOutlet weak var titleLbl: BatchLabelTitleBlack!
    
    @IBOutlet weak var rightBarBtnItem1: UIButton!
    
    @IBOutlet weak var rightBarBtnItem2: UIButton!
    
//    @IBOutlet weak var leftBarBtnItem: UIButton!
//    @IBOutlet weak var titleLbl: BatchLabelTitleBlack!

    // MARK: - Properties
    var view : UIView?
    var leftBarButtonTappedDelegate : secondBarButtonTappedDelegate?
    
    func xibSetup() {
        view = loadViewFromNib()
        view!.frame = bounds
        view!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view!)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomSecondNavigationBar", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        titleLbl.font = FontSize.mediumSize24

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
    
    /*
     func hideLeftBarButtonItem() {
     leftBarBtnItem.isHidden = true
     }
     */
    
    //MARK: UIButton Action Methods
    
    @IBAction func leftBarBtnTapped(_ sender: Any) {
        
        if leftBarButtonTappedDelegate != nil {
            leftBarButtonTappedDelegate?.leftBarButtonTapped!()
        } else {
            /*
             let controller = (self.superview)?.next as! UIViewController
             _ = controller.navigationController?.popViewController(animated: true)
             */
            let controller = (self.superview)?.next as! UIViewController
            _ = controller.dismiss(animated: true, completion: nil)
        }
    }
    
    
//
//    @IBAction func leftBarBtnTapped(_ sender: Any) {
//
//                if leftBarButtonTappedDelegate != nil {
//                    leftBarButtonTappedDelegate?.leftBarButtonTapped!()
//                } else {
//                    let controller = (self.superview)?.next as! UIViewController
//                    _ = controller.navigationController?.popViewController(animated: true)
//                }
//            }
    
}
