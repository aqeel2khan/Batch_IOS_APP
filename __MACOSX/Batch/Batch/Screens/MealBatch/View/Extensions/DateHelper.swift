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
    
    static func readableDateString(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            let secondsAgo = Int(now.timeIntervalSince(date))
            if secondsAgo < 60 {
                return "\(secondsAgo) seconds ago"
            } else if secondsAgo < 3600 {
                return "\(secondsAgo / 60) minutes ago"
            } else {
                return "\(secondsAgo / 3600) hours ago"
            }
        } else if let daysAgo = calendar.dateComponents([.day], from: date, to: now).day, daysAgo < 7 {
            return "\(daysAgo) days ago"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: date)
        }
    }
}
