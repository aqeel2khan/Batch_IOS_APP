//
//  BWorkOutMotivatorDetailModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/02/24.
//

import Foundation


// MARK: - Welcome
struct motivatorCoachListResponse: Codable {
    let status: Bool
    let message: String?
    let data: motivatorCoachListData?
}

// MARK: - DataClass
struct motivatorCoachListData: Codable {
    let list: [motivatorCoachListDataList]?
    let count: Int?
}

// MARK: - List
struct motivatorCoachListDataList: Codable {
    let courseID, userID: Int?
    let courseName, courseImage: String?
    let coursePromoVideo: String?
    let courseRepetition, courseValidity, description, perDayWorkout: String?
    let weightRequired, coursePrice: String?
    let discountPrice: String?
    let duration: String?
    let courseLevel: CourseLevel?
    let status: Int?
    let createdAt, updatedAt: String?
    let workoutType: [WorkoutType]?
    let goals: [Goal]?
    let coachDetail: CoachDetail?
    
    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case userID = "user_id"
        case courseName = "course_name"
        case courseImage = "course_image"
        case coursePromoVideo = "course_promo_video"
        case courseRepetition = "course_repetition"
        case courseValidity = "course_validity"
        case description
        case perDayWorkout = "per_day_workout"
        case weightRequired = "weight_required"
        case coursePrice = "course_price"
        case discountPrice = "discount_price"
        case duration
        case courseLevel = "course_level"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case workoutType = "workout_type"
        case goals
        case coachDetail = "coach_detail"
    }
}
