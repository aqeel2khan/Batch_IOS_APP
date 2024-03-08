//
//  UpdateBatchMealPlanRequest.swift
//  Batch
//
//  Created by Krupanshu Sharma on 06/03/24.
//

import Foundation

struct UpdateBatchMealPlanRequest: Codable {
    let userId, subscribedId, mealId, dayDishes: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case subscribedId = "subscribed_id"
        case mealId = "meal_id"
        case dayDishes = "day_dishes"
    }
}
