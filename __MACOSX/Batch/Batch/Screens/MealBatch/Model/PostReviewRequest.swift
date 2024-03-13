//
//  PostReviewRequest.swift
//  Batch
//
//  Created by Krupanshu Sharma on 11/03/24.
//

import Foundation

struct PostReviewRequest: Codable {
    var userId, dishId, rating, review: String
    var userName: String?
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case dishId = "dish_id"
        case rating = "rating"
        case review = "review"
        case userName = "user_name"
    }
}

// MARK: - PostReviewResponse
struct PostReviewResponse: Codable {
    let status: Bool
    let message: String
}


struct CheckSubscribedRequest: Codable {
    var userId, mealId: String
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case mealId = "meal_id"
    }
}

// MARK: - CheckSubscribedResponse
struct CheckSubscribedResponse: Codable {
    let status: Bool
    let message: String
    let data: CheckSubscribedResponseData?
}

// MARK: - CheckSubscribedResponseData
struct CheckSubscribedResponseData: Codable {
    let data: CheckSubscribedMeal?
    let status: String
}

// MARK: - DataData
struct CheckSubscribedMeal: Codable {
    let subscribed: Int
}
