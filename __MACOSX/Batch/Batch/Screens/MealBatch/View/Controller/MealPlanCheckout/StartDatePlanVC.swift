//
//  StartDatePlanVC.swift
//  Batch
//
//  Created by Chawtech on 26/01/24.
//

import UIKit
import FSCalendar

class StartDatePlanVC: UIViewController {

    var planStartDate = ""
    
    @IBOutlet weak var calenderStackView: UIStackView!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var lblCurrentmonthName: UILabel!
    
    @IBOutlet weak var leftArrowButton: UIButton!
    @IBOutlet weak var rightArrowBtn: UIButton!
    
    @IBOutlet weak var planCalender: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planCalender.delegate = self
        planCalender.dataSource = self
        calenderStackView.layer.cornerRadius = 20
        
        
        calenderStackView.layer.borderWidth = 0.5
        calenderStackView.layer.borderColor = Colors.appViewBackgroundColor.cgColor
        
        
        let timeStampCurrentDate = planCalender.currentPage.timeIntervalSince1970.description
       
        let currentMonthName = timeStampCurrentDate.getCurrentDate(dateStyle: .dateWithWholeMonthOnly)
       
        lblCurrentmonthName.text = currentMonthName
  
        
         let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
         mainView.addGestureRecognizer(tap)
     }
     
     @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
     //    self.dismiss(animated: true)
     }
    
    
    //MARK: Next Calendar Month
    func getNextMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    //MARK: Previous Calendar Month
    func getPreviousMonth(date:Date)->Date {
        return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    

    @IBAction func leftArrowActionBtn(_ sender: UIButton) {
        planCalender.setCurrentPage(getPreviousMonth(date: planCalender.currentPage), animated: true)
        
              updateDateAndMonth(planCalender)
    }
    
    
    @IBAction func rightArrowActionBtn(_ sender: UIButton) {
        planCalender.setCurrentPage(getNextMonth(date: planCalender.currentPage), animated: true)
            updateDateAndMonth(planCalender)

    }
    

    //MARK: Upadte Month & Year in Calendar header
    func updateDateAndMonth(_ calendar: FSCalendar) {

        let timeStampCurrentDate = calendar.currentPage.timeIntervalSince1970.description
       
        
        let currentMonthName = timeStampCurrentDate.getCurrentDate(dateStyle: .dateWithWholeMonthOnly)
       
      
        lblCurrentmonthName.text = currentMonthName

    }



    func convertToString (dateString: String, formatIn : String, formatOut : String) -> String {

       let dateFormater = DateFormatter()
        dateFormater.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
       dateFormater.dateFormat = formatIn
       let date = dateFormater.date(from: dateString)

       dateFormater.timeZone = NSTimeZone.system

       dateFormater.dateFormat = formatOut
       let timeStr = dateFormater.string(from: date!)
       return timeStr
    }
    
    @IBAction func btnApplyAction(_ sender: UIButton) {
        let vc = MealPlanAddressVC.instantiate(fromAppStoryboard: .batchMealPlanCheckout)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func backActionBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}



extension String {
        func getCurrentDate(dateStyle:CustomDateStylesTypes) -> String {
    
            let epochTime = (Double(self) ?? 0.0)
            let exactDate = Date.init(timeIntervalSince1970: epochTime)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = dateStyle.rawValue
            return dateFormatter.string(from: exactDate)
        }
}
