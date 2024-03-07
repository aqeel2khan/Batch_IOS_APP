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






// Follow API

// MARK: - Welcome
struct MotivatorFollowUnFollowResponse: Codable {
    let status: Bool
    let message: String?
    let data: MotivatorFollowUnFollowData?
    let error : MotivatorFollowResponseError?
}

// MARK: - DataClass
struct MotivatorFollowUnFollowData: Codable {
    let id, userType: Int?
    let name, email: String?
    let profilePhotoPath, fname, lname: String?
    let phone: String?
    let dob, gender: String?
    let userStatus: Int?
    let deviceToken, verificationCode, website, currency: String?
    let experience: String?
    let emailVerifiedAt, avatar: String?
    let createdAt, updatedAt: String?
    let lastLoginAt, lastLoginIP: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userType = "user_type"
        case name, email
        case profilePhotoPath = "profile_photo_path"
        case fname, lname, phone, dob, gender
        case userStatus = "user_status"
        case deviceToken = "device_token"
        case verificationCode = "verification_code"
        case website, currency, experience
        case emailVerifiedAt = "email_verified_at"
        case avatar
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lastLoginAt = "last_login_at"
        case lastLoginIP = "last_login_ip"
    }
}

struct MotivatorFollowResponseError : Codable {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
    }

}
