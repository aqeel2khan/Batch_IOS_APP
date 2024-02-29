//
//  DashboardWorkoutModel.swift
//  Batch
//
//  Created by Hari Mohan on 20/02/24.
//

import Foundation

//struct DashboardWorkoutModel: Codable {
//    let status: Bool
//    let message: String?
//    let data: DataClass?
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let list: [List]?
//    let count: Int?
//}
//
//// MARK: - List
//struct List: Codable {
//    let id, userID, courseID: Int?
//    let subtotal, discount, tax, total: String?
//    let paymentType, transactionID, paymentStatus, status: String?
//    let createdAt, updatedAt: String?
//    let courseDetail: WOSCourseDetail?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case courseID = "course_id"
//        case subtotal, discount, tax, total
//        case paymentType = "payment_type"
//        case transactionID = "transaction_id"
//        case paymentStatus = "payment_status"
//        case status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case courseDetail = "course_detail"
//    }
//}
//
//// MARK: - CourseDetail
//struct WOSCourseDetail: Codable {
//    let courseID, userID: Int?
//    let courseName, courseImage, coursePromoVideo, courseRepetition: String?
//    let courseValidity, description, perDayWorkout, weightRequired: String?
//    let coursePrice: String?
//    let discountPrice: String?
//    let duration: String?
//    let courseLevel: WOSCourseLevel?
//    let status: Int?
//    let createdAt, updatedAt: String?
//    let coachDetail: WOSCoachDetail?
//    let courseDuration: [WOSCourseDuration]?
//    let goals: [WOSGoal]?
//    let workoutType: [WOSWorkoutType]?
//
//    enum CodingKeys: String, CodingKey {
//        case courseID = "course_id"
//        case userID = "user_id"
//        case courseName = "course_name"
//        case courseImage = "course_image"
//        case coursePromoVideo = "course_promo_video"
//        case courseRepetition = "course_repetition"
//        case courseValidity = "course_validity"
//        case description
//        case perDayWorkout = "per_day_workout"
//        case weightRequired = "weight_required"
//        case coursePrice = "course_price"
//        case discountPrice = "discount_price"
//        case duration
//        case courseLevel = "course_level"
//        case status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case coachDetail = "coach_detail"
//        case courseDuration = "course_duration"
//        case goals
//        case workoutType = "workout_type"
//    }
//}
//
//
//// MARK: - CoachDetail
//struct WOSCoachDetail: Codable {
//    let id: Int?
//    let name, profilePhotoPath: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case profilePhotoPath = "profile_photo_path"
//    }
//}
//
//// MARK: - CourseDuration
//struct WOSCourseDuration: Codable {
//    let courseDurationID, courseID: Int?
//    let dayName, description: String?
//    let noOfExercise: Int?
//    let calorieBurn, workoutTime: String?
//    let status: Int?
//    let createdAt, updatedAt: AtedAt?
//    let courseDurationExercise: [WOSCourseDurationExercise]?
//
//
//    enum CodingKeys: String, CodingKey {
//        case courseDurationID = "course_duration_id"
//        case courseID = "course_id"
//        case dayName = "day_name"
//        case description
//        case noOfExercise = "no_of_exercise"
//        case calorieBurn = "calorie_burn"
//        case workoutTime = "workout_time"
//        case status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case courseDurationExercise = "course_duration_exercise"
//    }
//
//
//
//}

// MARK: - CourseDurationExercise
struct WOSCourseDurationExercise: Codable {
    let courseDurationExerciseID, courseDurationID: Int?
    let videoID: Int?
    let title, description, instruction, exerciseSet: String?
    let exerciseWraps: String?
    let exerciseTime: String?
    let createdAt: CreatedAt?
    let updatedAt: AtedAt?
    let videoDetail: WOSVideoDetail?

    enum CodingKeys: String, CodingKey {
        case courseDurationExerciseID = "course_duration_exercise_id"
        case courseDurationID = "course_duration_id"
        case videoID = "video_id"
        case title, description, instruction
        case exerciseSet = "exercise_set"
        case exerciseWraps = "exercise_wraps"
        case exerciseTime = "exercise_time"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case videoDetail = "video_detail"
    }
}

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
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case folderID = "folder_id"
        case videoTitle = "video_title"
        case videoDescription = "video_description"
        case videoID = "video_id"
        case duration, width, height, status
        case playerEmbedURL = "player_embed_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
//
//// MARK: - CourseLevel
//struct WOSCourseLevel: Codable {
//    let id: Int?
//    let levelName: String?
//    let status: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case levelName = "level_name"
//        case status
//    }
//}
//
//// MARK: - Goal
//struct WOSGoal: Codable {
//    let id, courseID, goalID: Int?
//    let batchgoal: [WOSBatchgoal]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case courseID = "course_id"
//        case goalID = "goal_id"
//        case batchgoal
//    }
//}
//
//// MARK: - Batchgoal
//struct WOSBatchgoal: Codable {
//    let id: Int?
//    let goalName: String?
//    let status: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case goalName = "goal_name"
//        case status
//    }
//}
//
//// MARK: - WorkoutType
//struct WOSWorkoutType: Codable {
//    let id, courseID, workoutTypeID: Int?
//    let workoutdetail: WOSWorkoutdetail?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case courseID = "course_id"
//        case workoutTypeID = "workout_type_id"
//        case workoutdetail
//    }
//}
//
//// MARK: - Workoutdetail
//struct WOSWorkoutdetail: Codable {
//    let id: Int?
//    let workoutType: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case workoutType = "workout_type"
//    }
//}
//
//
//
//
//
//
//

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
    let createdAt, updatedAt: String?
    let courseDetail: CourseDetail?
//    let todayWorkouts: TodayWorkoutsUnion?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case courseID = "course_id"
        case subtotal, discount, tax, total
        case paymentType = "payment_type"
        case transactionID = "transaction_id"
        case paymentStatus = "payment_status"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case courseDetail = "course_detail"
//        case todayWorkouts = "today_workouts"
    }
}

struct TodayWorkoutsElement: Codable {
    let courseDurationID, courseID: Int?
    let dayName, description: String?
    let noOfExercise: Int?
    let calorieBurn, workoutTime: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let row: Int?
    let courseDurationExercise: [WOSCourseDurationExercise]?

    enum CodingKeys: String, CodingKey {
        case courseDurationID = "course_duration_id"
        case courseID = "course_id"
        case dayName = "day_name"
        case description
        case noOfExercise = "no_of_exercise"
        case calorieBurn = "calorie_burn"
        case workoutTime = "workout_time"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case row = "Row"
        case courseDurationExercise = "course_duration_exercise"
    }
}


enum TodayWorkoutsUnion: Codable {
    case string(String)
    case todayWorkoutsElement(TodayWorkoutsElement)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(TodayWorkoutsElement.self) {
            self = .todayWorkoutsElement(x)
            return
        }
        throw DecodingError.typeMismatch(TodayWorkoutsUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for TodayWorkoutsUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .todayWorkoutsElement(let x):
            try container.encode(x)
        }
    }
}
