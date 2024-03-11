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
