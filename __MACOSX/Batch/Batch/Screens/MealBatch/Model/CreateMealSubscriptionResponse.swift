//
//  CreateMealSubscriptionResponse.swift
//  Batch
//
//  Created by Krupanshu Sharma on 03/03/24.
//

import Foundation

// MARK: - CreateMealSubscriptionResponse
struct CreateMealSubscriptionResponse: Codable {
    let status: Bool?
    let message: String?
    // let data: MealSubscriptionData?
}

// MARK: - DataClass
struct MealSubscriptionData: Codable {
    let userID, mealID, subtotal, duration: String?
    let discount, tax: String?
    let total, paymentType, transactionID, paymentStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case mealID = "meal_id"
        case subtotal, duration
        case discount, tax, total
        case paymentType = "payment_type"
        case transactionID = "transaction_id"
        case paymentStatus = "payment_status"
    }
}
