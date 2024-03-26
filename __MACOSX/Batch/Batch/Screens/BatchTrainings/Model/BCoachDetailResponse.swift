//
//  BCoachDetailResponse.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/03/24.
//

import Foundation

// MARK: - Welcome
struct BCoachDetailResponse: Codable {
    let status: Bool?
    let message: String?
    let data: BCoachDetailResponseData?
}

// MARK: - DataClass
struct BCoachDetailResponseData: Codable {
    let id, userType: Int?
    let name, email, profilePhotoPath, fname: String?
    let lname, phone: String?
    let dob, gender: String?
    let userStatus: Int?
    let deviceToken, verificationCode, website, currency: String?
    let experience: Int?
    let emailVerifiedAt, avatar, createdAt: String?
    let updatedAt: String?
    let lastLoginAt, lastLoginIP: String?
    let followersCount, youFollowedCount: Int?
    let workoutType: [WorkoutType]?

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
        case followersCount = "followers_count"
        case youFollowedCount = "you_followed_count"
        case workoutType = "workout_type"
    }
}
