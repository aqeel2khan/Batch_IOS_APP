//
//  Extension+StartPlanCheckoutVC.swift
//  Batch
//
//  Created by Chawtech on 26/01/24.
//

import Foundation
import UIKit
import FSCalendar


enum CustomDateStylesTypes:String {

    case dateWithWholeMonthOnly = "MMMM YYYY"

}

extension StartDatePlanVC: FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance {
    
    func convertDate(date:Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =   "YYYY/MM/dd" //"dd, MMMM yyyy HH:mm:a"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let endDate = dateFormatter.string(from: date as Date)
        return endDate
    }
    
    func convertDays(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =   "dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let endDate = dateFormatter.string(from: date as Date)
        return endDate
    }
    

}

