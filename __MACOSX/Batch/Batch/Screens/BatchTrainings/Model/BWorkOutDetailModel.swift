//
//  BWorkOutDetailModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

// MARK: - Course Detail
struct CourseDetailsResponse: Codable {
    let status: Bool
    let message: String?
    let data: CourseDetailsData?
}

// MARK: - DataClass
struct CourseDetailsData: Codable {
    let courseID, userID: Int?
    let courseName, courseImage, coursePromoVideo, courseRepetition: String?
    let courseValidity, description, perDayWorkout, weightRequired: String?
    let coursePrice: String?
    let discountPrice: String?
    let duration: String?
    let courseLevel: CourseDetailLevel?
    let status: Int?
    let createdAt, updatedAt: String?
    let coachDetail: CoachDetails?
    let courseDuration: [CourseDetailDuration]?
    let goals: [GoalDetail]?
    let workoutType: [WorkoutTypeDetail]?
    
    
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
    }
}

// MARK: - CoachDetail
struct CoachDetails: Codable {
    let id: Int?
    let name: String?
    let profilePhotoPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profilePhotoPath = "profile_photo_path"
    }
}

// MARK: - CourseDuration
struct CourseDetailDuration: Codable {
    let courseDurationID, courseID: Int?
    let dayName, description: String?
    let noOfExercise: Int?
    let calorieBurn, workoutTime: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let courseDurationExercise: [CourseDetailDurationExercise]?

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
struct CourseDetailDurationExercise: Codable {
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

// MARK: - CourseLevel
struct CourseDetailLevel: Codable {
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
struct GoalDetail: Codable {
    let id, courseID, goalID: Int?
    let batchgoal: [Batchgoaldetail]?

    enum CodingKeys: String, CodingKey {
        case id
        case courseID = "course_id"
        case goalID = "goal_id"
        case batchgoal
    }
}

// MARK: - Batchgoal
struct Batchgoaldetail: Codable {
    let id: Int?
    let goalName: String?
    let status: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case goalName = "goal_name"
        case status
    }
}

// MARK: - WorkoutType
struct WorkoutTypeDetail: Codable {
    let id, courseID, workoutTypeID: Int?
    let workoutdetail: Workouttypedetail?

    enum CodingKeys: String, CodingKey {
        case id
        case courseID = "course_id"
        case workoutTypeID = "workout_type_id"
        case workoutdetail
    }
}

// MARK: - Workoutdetail
struct Workouttypedetail: Codable {
    let id: Int?
    let workoutType: String?

    enum CodingKeys: String, CodingKey {
        case id
        case workoutType = "workout_type"
    }
}







//
//// MARK: - Welcome
//struct CourseDetailsResponse: Codable {
//    let status: Bool
//    let message: String?
//    let data: CourseDetailsData?
//}
//struct CourseDetailsData: Codable {
//    let courseID, userID: Int?
//    let courseName, courseImage, coursePromoVideo, courseRepetition: String?
//    let courseValidity, description, perDayWorkout, weightRequired: String?
//    let coursePrice: String?
//    let discountPrice: String?
//    let duration: String?
//    let courseLevel: CourseDetailLevel
//    let status: Int?
//    let createdAt, updatedAt: String?
//    let coachDetail: CoachDetails?
//    let courseDuration: [CourseDetailDuration]?
//    let goals: [GoalDetail]?
//    let workoutType: [WorkoutTypeDetail]?
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
//// MARK: - CoachDetail
//struct CoachDetails: Codable {
//    let id: Int?
//    let name: String?
//    let profilePhotoPath: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case profilePhotoPath = "profile_photo_path"
//    }
//}
//
//// MARK: - CourseDuration
//struct CourseDetailDuration: Codable {
//    let courseDurationID, courseID: Int?
//    let dayName, description: String?
//    let noOfExercise: Int?
//    let calorieBurn, workoutTime: String?
//    let status: Int?
//    let createdAt, updatedAt: String?
//    let courseDurationExercise: [CourseDetailDurationExercise]?
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
//struct CourseDetailDurationExercise: Codable {
//    let courseDurationExerciseID, courseDurationID: Int?
//    let videoID, title, description, instruction: String?
//    let exerciseSet, exerciseWraps, exerciseTime: String?
//    let createdAt, updatedAt: String?
//    let videoDetail: String?
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
//// MARK: - CourseLevel
//struct CourseDetailLevel: Codable {
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
//struct GoalDetail: Codable {
//    let id, courseID, goalID: Int?
//    let batchgoal: [BatchgoalDetail]?
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
//struct BatchgoalDetail: Codable {
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
//struct WorkoutTypeDetail: Codable {
//    let id, courseID, workoutTypeID: Int?
//    let workoutdetail: Workoutdetail?
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
//struct Workoutdetails: Codable {
//    let id: Int?
//    let workoutType: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case workoutType = "workout_type"
//    }
//}



// MARK: - Course Detail Response
struct CourseDetailResponse: Codable {
    let status: Bool
    let message: String?
    let data: CourseDetailData?
}
struct CourseDetailData: Codable {
    let courseID, userID: Int?
    let courseName, courseImage, coursePromoVideo, courseRepetition: String?
    let courseValidity, description, perDayWorkout, weightRequired: String
    let coursePrice: String?
    let discountPrice: String?
    let duration: String?
    let courseLevel, status: Int?
    let createdAt, updatedAt: String?
    let courseDuration: [CourseDuration]?
    let goals: [Goal]?
    let workoutType: [WorkoutTypeBDetail]?

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
        case courseDuration = "course_duration"
        case goals
        case workoutType = "workout_type"
    }
}

// MARK: - CourseDuration

struct CourseDuration: Codable {
    let courseDurationID, courseID: Int?
    let dayName, description: String?
    let noOfExercise: Int?
    let calorieBurn, workoutTime: String?
    let status: Int?
    let createdAt, updatedAt: String?
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
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case courseDurationExercise = "course_duration_exercise"
    }
}

// MARK: - CourseDurationExercise

struct CourseDurationExercise: Codable {
    let courseDurationExerciseID, courseDurationID, videoID: Int?
    let title, description, instruction, exerciseSet: String?
    let exerciseWraps, exerciseTime: String?
    let createdAt, updatedAt: String?
    let videoDetail: VideoDetail?

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
// VideoDetail
struct VideoDetail: Codable {
    let id, userID, folderID: Int?
    let videoTitle: String?
    let videoDescription: String?
    let videoID, duration, width, height: String?
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

// MARK: - Goal

struct Goal: Codable {
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

struct Batchgoal: Codable {
    let id: Int?
    let goalName: String?
    let status: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case goalName = "goal_name"
        case status
    }
}

// MARK: - WorkoutType

struct WorkoutTypeBDetail: Codable {
    let id, courseID, workoutTypeID: Int
    let workoutdetail: WorkoutdetailB

    enum CodingKeys: String, CodingKey {
        case id
        case courseID = "course_id"
        case workoutTypeID = "workout_type_id"
        case workoutdetail
    }
}

// MARK: - Workoutdetail

struct WorkoutdetailB: Codable {
    let id: Int
    let workoutType: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case id
        case workoutType = "workout_type"
        case status
    }
}

// MARK: - Motivator Detail -- Coach Detail

struct CoachDetailResponse: Codable {
    let status: Bool?
    let message: String?
    let data: CoachDetailData?
}
struct CoachDetailData: Codable {
    let id, userType: Int?
    let name, email: String?
    let profilePhotoPath: String?
    let fname, lname, phone: String?
    let dob: String?
    let gender: String?
    let website: String?
    let currnecy: String?
    let userStatus: Int?
    let deviceToken, verificationCode, emailVerifiedAt, avatar: String?
    let createdAt, updatedAt, lastLoginAt, lastLoginIP: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userType = "user_type"
        case name, email
        case profilePhotoPath = "profile_photo_path"
        case fname, lname, phone, dob, gender, website, currnecy
        case userStatus = "user_status"
        case deviceToken = "device_token"
        case verificationCode = "verification_code"
        case emailVerifiedAt = "email_verified_at"
        case avatar
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lastLoginAt = "last_login_at"
        case lastLoginIP = "last_login_ip"
    }
}

// MARK: - CourseWorkout Detail

struct CourseWorkoutDetailModel: Codable {
    let status: Bool
    let message: String?
    let data: CourseWorkoutDetailData
}
struct CourseWorkoutDetailData: Codable {
    let list: [CourseWorkoutDetailList]?
    let count: Int?
}
struct CourseWorkoutDetailList: Codable {
    let courseDurationExerciseID, courseDurationID, videoID: Int?
    let title, description, instruction, exerciseSet: String?
    let exerciseWraps, exerciseTime: String?
    let createdAt, updatedAt: String?

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
    }
}
