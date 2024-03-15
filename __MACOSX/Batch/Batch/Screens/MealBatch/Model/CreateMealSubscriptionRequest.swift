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


struct SubscriptionRequest: Encodable {
    let userId: Int
    let mealId: Int
    let subtotal: Int
    let discount: Int
    let tax: Int
    let total: Int
    let paymentType: String
    let transactionId: String
    let paymentStatus: String
    let startDate: String
    let duration: Int
    let latitude: Double
    let longitude: Double
    let area: String
    let block: String
    let house: String
    let street: String
    let addressType: String
    let deliveryTime: String
    let deliveryArriving: String
    let deliveryDropoff: String
    let deliveryTimeId: Int
    let deliveryArrivingId: Int
    let deliveryDropoffId: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case mealId = "meal_id"
        case subtotal, discount, tax, total
        case paymentType = "payment_type"
        case transactionId = "transaction_id"
        case paymentStatus = "payment_status"
        case startDate = "start_date"
        case duration, latitude, longitude, area, block, house, street
        case addressType = "address_type"
        case deliveryTime = "delivery_time"
        case deliveryArriving = "delivery_arriving"
        case deliveryDropoff = "delivery_dropoff"
        case deliveryTimeId = "delivery_time_id"
        case deliveryArrivingId = "delivery_arriving_id"
        case deliveryDropoffId = "delivery_dropoff_id"
    }
}
