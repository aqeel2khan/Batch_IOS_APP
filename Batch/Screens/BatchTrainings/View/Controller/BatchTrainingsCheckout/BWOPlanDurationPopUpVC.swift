//
//  BWOPlanDurationPopUpVC.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 21/01/24.
//

import UIKit
import DropDown


class BWOPlanDurationPopUpVC: UIViewController {
    
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var popUpTitleLbl: BatchLabelTitleBlack!
    @IBOutlet weak var popUpDDTextField: UITextField!
    @IBOutlet weak var popUpSaveBtn: BatchButton!
    
    @IBOutlet weak var dropDownBtn: UIButton!
    
    var isCommingFrom = ""
    //Drop Down
    lazy var planDurationDropDown = DropDown()
    var planDurationArray = ["2 weeks ($35)","1month($60)"]
    
    var selectedPlanDurationStr = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popUpDDTextField.text = "2 weeks ($35)"
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
        
        if isCommingFrom == "MealPlanAddressVC"
        {
            self.popUpTitleLbl.text      = "Delivery Time"
            self.popUpDDTextField.text   = "12:00 PM - 1:00 PM"
            self.popUpSaveBtn.setTitle("Applye", for: .normal)
        }
        
        
        //        //DropDown
        //        planDurationDropDown.anchorView = dropDownBtn
        //        createDropDownButton(dropDownBtn)
        
    }
    //    func createDropDownButton(_ button: UIButton){
    //        button.layer.cornerRadius = 10
    //        button.layer.borderWidth = 1
    //        button.layer.borderColor = UIColor.lightGray.cgColor
    //
    //    }
    private func createDropDownForPlanDuration(){
        
        let countryDropDown = DropDown()
        countryDropDown.anchorView = dropDownBtn
        countryDropDown.dismissMode = .automatic
        countryDropDown.direction = .bottom
        countryDropDown.bottomOffset = CGPoint(x: 10, y: dropDownBtn.bounds.height)
        countryDropDown.width = dropDownBtn.frame.width - 20
        //        var countryList = [String]()
        //        countries.forEach { (country) in
        //            countryList.append(country.country!)
        //        }
        countryDropDown.dataSource = planDurationArray
        countryDropDown.show()
        
        countryDropDown.selectionAction  = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.popUpDDTextField.text = item
        }
    }
    
    
    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onTapBackBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onTapPlanDurationDDBtn(_ sender: Any) {
        
        //        let appearance = DropDown.appearance()
        //
        //        appearance.cellHeight = 40
        //        appearance.backgroundColor = UIColor(white: 1, alpha: 1)
        //        appearance.selectionBackgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        //        appearance.shadowOpacity = 0.4
        //        appearance.shadowRadius = 4
        //        appearance.animationduration = 0.10
        //        appearance.textColor = .darkGray
        //
        //        planDurationDropDown.dismissMode = .automatic
        //        planDurationDropDown.direction = .bottom
        //        planDurationDropDown.bottomOffset = CGPoint(x: 0, y: dropDownBtn.bounds.height)
        //        planDurationDropDown.width = dropDownBtn.frame.width
        //
        //        planDurationDropDown.show()
        //        planDurationDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
        //            dropDownBtn.setTitle(item, for: .normal)
        //            self.popUpDDTextField.text = item
        //        }
        
        createDropDownForPlanDuration()
    }
    //    {
    //
    //        self.selectedLength = self.lengthArray[0]
    //        self.btnLength.setTitle(self.lengthArray[0], for: .normal)
    //    }
    
    @IBAction func onTapSaveBtn(_ sender: Any) {
        if isCommingFrom == "MealPlanAddressVC"
        {
            let vc = MealDilevaryArrivingVC.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true )
        }
        else
        {
            selectedPlanDurationStr = self.popUpDDTextField.text ?? ""
            // Inside some function or method
            let notification = Notification(name: .myCustomNotification, object: nil, userInfo: ["key": "\(selectedPlanDurationStr)"])
            NotificationCenter.default.post(notification)
            
            self.dismiss(animated: true)
        }
    }
    
}
