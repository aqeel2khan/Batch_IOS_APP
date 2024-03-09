//
//  SubscribedMealListRequest.swift
//  Batch
//
//  Created by Krupanshu Sharma on 03/03/24.
//

import Foundation

struct SubscribedMealListRequest: Codable {
    var userId: String?
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}

struct SubscribedMealDetailRequest: Codable {
    var userId, subscribedId, mealId, goalId: String?
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case subscribedId = "subscribed_id"
        case mealId = "meal_id"
        case goalId = "goal_id"
    }
}
