//
//  DateHelper.swift
//  Batch
//
//  Created by Krupanshu Sharma on 09/03/24.
//

import Foundation

class DateHelper {
    static func isOldDate(_ date: Date) -> Bool {
        let currentDate = Date()
        return date < currentDate
    }
    
    static func isDateGreaterThanTwoDays(_ date: Date) -> Bool {
        let currentDate = Date()
        let twoDaysFromNow = Calendar.current.date(byAdding: .day, value: 2, to: currentDate)!
        return date > twoDaysFromNow
    }
    
    static func getDay(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    static func getMonth(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: date)
    }
}
