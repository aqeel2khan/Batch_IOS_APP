//
//  CourseDetaolWSModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 20/02/24.
//

import Foundation

// MARK: - Welcome
struct CourseDetailWSResponse: Codable {
    let status: Bool
    let message: String?
    let data: CourseDetailWSData?
}

// MARK: - DataClass
struct CourseDetailWSData: Codable {
    let courseID, userID: Int?
    let courseName, courseImage, coursePromoVideo, courseRepetition: String?
    let courseValidity, description, perDayWorkout, weightRequired: String?
    let coursePrice: String?
    let discountPrice: String?
    let duration: String?
    let courseLevel: CourseLevelWS?
    let status: Int?
    let createdAt, updatedAt: String?
    let coachDetail: CoachDetailWS?
    let courseDuration: [CourseDurationWS]?
    let goals: [GoalWS]?
    let workoutType: [WorkoutTypeWS]?
    let workouts: [TodayWorkoutsElement]?

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
        case coachDetail = "coach_detail"
        case courseDuration = "course_duration"
        case goals
        case workoutType = "workout_type"
        case workouts
    }
}

// MARK: - CoachDetail
struct CoachDetailWS: Codable {
    let id: Int?
    let name, profilePhotoPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profilePhotoPath = "profile_photo_path"
    }
}

//// MARK: - CourseDuration
//struct CourseDurationWS: Codable {
//    let courseDurationID, courseID: Int?
//    let dayName, description: String?
//    let noOfExercise: Int?
//    let calorieBurn, workoutTime: String?
//    let status: Int?
//    let createdAt, updatedAt: AtedAt?
//    let courseDurationExercise: [CourseDurationExerciseWS]?
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
//}
//
//// MARK: - CourseDurationExercise
//struct CourseDurationExerciseWS: Codable {
//    let courseDurationExerciseID, courseDurationID: Int?
//    let videoID: Int?
//    let title, description, instruction, exerciseSet: String?
//    let exerciseWraps: String?
//    let exerciseTime: String?
//    let createdAt: CreatedAt?
//    let updatedAt: AtedAt?
//    let videoDetail: VideoDetailWS?
//
//    enum CodingKeys: String, CodingKey {
//        case courseDurationExerciseID = "course_duration_exercise_id"
//        case courseDurationID = "course_duration_id"
//        case videoID = "video_id"
//        case title, description, instruction
//        case exerciseSet = "exercise_set"
//        case exerciseWraps = "exercise_wraps"
//        case exerciseTime = "exercise_time"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case videoDetail = "video_detail"
//    }
//}
//
//enum CreatedAt: String, Codable {
//    case the20240216T131134000000Z = "2024-02-16T13:11:34.000000Z"
//    case the20240216T135328000000Z = "2024-02-16T13:53:28.000000Z"
//}
//
//enum AtedAt: String, Codable {
//    case the20240216T135240000000Z = "2024-02-16T13:52:40.000000Z"
//    case the20240216T135328000000Z = "2024-02-16T13:53:28.000000Z"
//}
//
//// MARK: - VideoDetail
//struct VideoDetailWS: Codable {
//    let id, userID, folderID: Int?
//    let videoTitle, videoDescription, videoID, duration: String?
//    let width, height: String?
//    let status: Int?
//    let playerEmbedURL: String?
//    let createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case folderID = "folder_id"
//        case videoTitle = "video_title"
//        case videoDescription = "video_description"
//        case videoID = "video_id"
//        case duration, width, height, status
//        case playerEmbedURL = "player_embed_url"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}

// MARK: - CourseLevel
struct CourseLevelWS: Codable {
    let id: Int?
    let levelName: String?
    let status: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case levelName = "level_name"
        case status
    }
}

// MARK: - Goal
struct GoalWS: Codable {
    let id, courseID, goalID: Int?
    let batchgoal: [Batchgoal]?

    enum CodingKeys: String, CodingKey {
        case id
        case courseID = "course_id"
        case goalID = "goal_id"
        case batchgoal
    }
}

// MARK: - Batchgoal
struct BatchgoalWS: Codable {
    let id: Int?
    let goalName: String?
    let status: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case goalName = "goal_name"
        case status
    }
}

//// MARK: - WorkoutType
//struct WorkoutTypeWS: Codable {
//    let id, courseID, workoutTypeID: Int?
//    let workoutdetail: WorkoutdetailWS?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case courseID = "course_id"
//        case workoutTypeID = "workout_type_id"
//        case workoutdetail
//    }
//}
struct WorkoutTypeWS: Codable {
    let courseDurationID, courseID: Int?
    let dayName: String?
    let description: String?
    let noOfExercise: Int?
    let calorieBurn, workoutTime: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let row: Int?

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
    }
}



// MARK: - Workoutdetail
struct WorkoutdetailWS: Codable {
    let id: Int?
    let workoutType: String

    enum CodingKeys: String, CodingKey {
        case id
        case workoutType = "workout_type"
    }
}

// MARK: - CourseDuration
struct CourseDurationWS: Codable {
    let courseDurationID, courseID: Int?
    let dayName, description: String?
    let noOfExercise: Int?
    let calorieBurn, workoutTime: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let courseDurationExercise: [CourseDurationExerciseWS]?

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
        case courseDurationExercise = "course_duration_exercise"
    }
}

// MARK: - CourseDurationExercise
struct CourseDurationExerciseWS: Codable {
    let courseDurationExerciseID, courseDurationID: Int?
    let videoID, title, description, instruction: String?
    let exerciseSet, exerciseWraps, exerciseTime: String?
    let createdAt, updatedAt: String?
    let videoDetail: String?

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
