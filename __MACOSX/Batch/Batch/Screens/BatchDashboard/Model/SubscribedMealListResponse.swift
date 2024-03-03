//
//  SubscribedMealListResponse.swift
//  Batch
//
//  Created by Krupanshu Sharma on 03/03/24.
//

import Foundation

struct SubscribedMealListResponse: Codable {
    let status: Bool?
    let message: String?
    let data: SubScribedMealsData?
}

// MARK: - DataClass
struct SubScribedMealsData: Codable {
    let data: [SubscribedMeals]?
    let status: String?
    let recordsTotal: Int?
}

// MARK: - Datum
struct SubscribedMeals: Codable {
    let id, subscribedId, restaurantID, batchID, goalID: Int?
    let name, nameAr, price, duration: String?
    let discount: Int?
    let description, descriptionAr: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let avgCalPerDay: String?
    let mealCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case subscribedId = "subscribed_id"
        case restaurantID = "restaurant_id"
        case batchID = "batch_id"
        case goalID = "goal_id"
        case name
        case nameAr = "name_ar"
        case price, duration, discount, description
        case descriptionAr = "description_ar"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case avgCalPerDay = "avg_cal_per_day"
        case mealCount = "meal_count"
    }
}
