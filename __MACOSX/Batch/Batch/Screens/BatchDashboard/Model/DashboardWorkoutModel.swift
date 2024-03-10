//
//  DashboardWorkoutModel.swift
//  Batch
//
//  Created by Hari Mohan on 20/02/24.
//

import Foundation
//
//// MARK: - CourseDurationExercise
//struct WOSCourseDurationExercise: Codable {
//    let courseDurationExerciseID, courseDurationID: Int?
//    let videoID: Int?
//    let title, description, instruction, exerciseSet: String?
//    let exerciseWraps: String?
//    let exerciseTime: String?
////    let createdAt: CreatedAt?
////    let updatedAt: AtedAt?
//    let videoDetail: WOSVideoDetail?
//
//    enum CodingKeys: String, CodingKey {
//        case courseDurationExerciseID = "course_duration_exercise_id"
//        case courseDurationID = "course_duration_id"
//        case videoID = "video_id"
//        case title, description, instruction
//        case exerciseSet = "exercise_set"
//        case exerciseWraps = "exercise_wraps"
//        case exerciseTime = "exercise_time"
////        case createdAt = "created_at"
////        case updatedAt = "updated_at"
//        case videoDetail = "video_detail"
//    }
//}

enum CreatedAt: String, Codable {
    case the20240216T131134000000Z = "2024-02-16T13:11:34.000000Z"
    case the20240216T135328000000Z = "2024-02-16T13:53:28.000000Z"
}

enum AtedAt: String, Codable {
    case the20240216T135240000000Z = "2024-02-16T13:52:40.000000Z"
    case the20240216T135328000000Z = "2024-02-16T13:53:28.000000Z"
}

// MARK: - VideoDetail
struct WOSVideoDetail: Codable {
    let id, userID, folderID: Int?
    let videoTitle, videoDescription, videoID, duration: String?
    let width, height: String?
    let status: Int?
    let playerEmbedURL: String?
//    let createdAt: CreatedAt?
//let updatedAt: AtedAt?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case folderID = "folder_id"
        case videoTitle = "video_title"
        case videoDescription = "video_description"
        case videoID = "video_id"
        case duration, width, height, status
        case playerEmbedURL = "player_embed_url"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
    }
}

//****************************************************

// MARK: - Dashboard Work Out Subscribed List Response
struct DashboardWOResponse: Codable {
    let status: Bool
    let message: String?
    let data: DashboardWOData?
}

// MARK: - DataClass
struct DashboardWOData: Codable {
    let list: [DashboardWOList]?
    let count: Int?
}

// MARK: - List
struct DashboardWOList: Codable {
    let id, userID, courseID: Int?
    let subtotal, discount, tax, total: String?
    let paymentType, transactionID, paymentStatus, status: String?
    let endDate: String?
//    let createdAt: CreatedAt?
//let updatedAt: AtedAt?
    let startDate: String?
    let courseDetail: CourseDetail?
    let todayWorkouts: TodayWorkoutsElement?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case courseID = "course_id"
        case subtotal, discount, tax, total
        case paymentType = "payment_type"
        case transactionID = "transaction_id"
        case paymentStatus = "payment_status"
        case status
        case endDate = "end_date"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
        case startDate = "start_date"
        case todayWorkouts = "today_workouts"
        case courseDetail = "course_detail"
    }
}

struct TodayWorkoutsElement: Codable {
    let courseDurationID, courseID: Int?
    let dayName, description: String?
    let noOfExercise: Int?
    let calorieBurn, workoutTime: String?
    let status: Int?
//    let createdAt: CreatedAt?
//let updatedAt: AtedAt?
    let row: Int?
    let courseDurationExercise: [CourseDurationExercise]?

    
    
    enum CodingKeys: String, CodingKey {
        case courseDurationID = "course_duration_id"
        case courseID = "course_id"
        case dayName = "day_name"
        case description
        case noOfExercise = "no_of_exercise"
        case calorieBurn = "calorie_burn"
        case workoutTime = "workout_time"
        case status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
        case row = "Row"
        case courseDurationExercise = "course_duration_exercise"
    }
}


struct CalloriesBurned{
    let cal: Double
    let date: Date
    
    init(cal: Double, date: Date) {
        self.cal = cal
        self.date = date
    }
}
