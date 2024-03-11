//
//  DishReviewListResponse.swift
//  Batch
//
//  Created by Krupanshu Sharma on 11/03/24.
//

import Foundation

// MARK: - DishReviewListResponse
struct DishReviewListResponse: Codable {
    let status: Bool
    let message: String
    let data: DishReviews
}

// MARK: - DataClass
struct DishReviews: Codable {
    let data: [DishReview]
    let status: String
    let recordsTotal: Int
}

// MARK: - Datum
struct DishReview: Codable {
    let id, dishID: Int
    let review: String
    let rating: Int
    let userName: String
    let userID: Int
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case dishID = "dish_id"
        case review, rating
        case userName = "user_name"
        case userID = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
