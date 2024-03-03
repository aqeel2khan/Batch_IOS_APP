//
//  CreateMealSubscriptionRequest.swift
//  Batch
//
//  Created by Krupanshu Sharma on 03/03/24.
//

import Foundation

struct CreateMealSubscriptionRequest: Codable {
    var userId, mealId, subtotal, discount, tax, total, paymentType, transactionId, paymentStatus, startDate, duration: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case mealId = "meal_id"
        case subtotal = "subtotal"
        case discount = "discount"
        case tax = "tax"
        case total = "total"
        case paymentType = "payment_type"
        case transactionId = "transaction_id"
        case paymentStatus = "payment_status"
        case duration = "duration"
        case startDate = "start_date"
    }
}
