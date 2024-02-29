//
//  BWorkOutModel.swift
//  Batch
//
//  Created by shashivendra sengar on 13/02/24.
//

import Foundation

////MARK: - Coach List Response
//struct CoachListResponse: Codable {
//    let status: Bool?
//    let message: String?
//    let data: [CoachListData]?
//}
//struct CoachListData: Codable {
//    let id, userType: Int?
//    let name, email: String?
//    let profilePhotoPath: String?
//    let fname, lname, phone: String?
//    let dob, gender, userStatus, deviceToken: String?
//    let verificationCode: String?
//    let website: String?
//    let currency: String?
//    let emailVerifiedAt, avatar, createdAt: String?
//    let updatedAt: String?
//    let lastLoginAt, lastLoginIP: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userType = "user_type"
//        case name, email
//        case profilePhotoPath = "profile_photo_path"
//        case fname, lname, phone, dob, gender
//        case userStatus = "user_status"
//        case deviceToken = "device_token"
//        case verificationCode = "verification_code"
//        case website, currency
//        case emailVerifiedAt = "email_verified_at"
//        case avatar
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case lastLoginAt = "last_login_at"
//        case lastLoginIP = "last_login_ip"
//    }
//}

// MARK: - Course List

struct CourseResponse: Codable {
    let status: Bool?
    let message: String?
    let data: CourseData?
}
struct CourseData: Codable {
    let list: [CourseDataList]?
    let count: Int?
}
struct CourseDataList: Codable {
    let courseID, userID: Int?
    let courseName: String?
    let courseImage, coursePromoVideo: String?
    let courseRepetition, courseValidity, description: String?
    let perDayWorkout, weightRequired, coursePrice: String?
    let discountPrice: String?
    let duration: String?
    let courseLevel: CourseLevel?
    let status: Int?
    let createdAt, updatedAt: String
    let workoutType: [WorkoutType]?
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
        case coachDetail = "coach_detail"
    }
}
// MARK: - CourseDetail
struct CourseDetail: Codable {
    let courseID, userID: Int?
    let courseName, courseImage, coursePromoVideo, courseRepetition: String?
    let courseValidity, description, perDayWorkout, weightRequired: String?
    let coursePrice: String?
    let discountPrice: String?
    let duration: String?
    let courseLevel: CourseLevel?
    let status: Int?
    let createdAt, updatedAt: String?
    let coachDetail: CoachDetail?
    let courseDuration: [CourseDuration]?
    let goals: [Goal]?
    let workoutType: [WorkoutType]?

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

struct CoachDetail: Codable {
    let id: Int?
    let name: String?
    let profilePhotoPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case profilePhotoPath = "profile_photo_path"
    }
}
struct CourseLevel: Codable {
    let id: Int?
    let levelName: String?
    let status: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case levelName = "level_name"
        case status
    }
}
struct WorkoutType: Codable {
    let id, courseID, workoutTypeID: Int?
    let workoutdetail: Workoutdetail?

    enum CodingKeys: String, CodingKey {
        case id
        case courseID = "course_id"
        case workoutTypeID = "workout_type_id"
        case workoutdetail
    }
}

struct Workoutdetail: Codable {
    let id: Int?
    let workoutType: String?

    enum CodingKeys: String, CodingKey {
        case id
        case workoutType = "workout_type"
    }
}
//struct WorkoutTypeElement: Codable {
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
//struct Workoutdetail: Codable {
//    let id: Int?
//    let workoutType: WorkoutTypeEnum?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case workoutType = "workout_type"
//    }
//}
//enum WorkoutTypeEnum: String, Codable {
//    case pilates = "Pilates"
//    case stretching = "Stretching"
//    case yoga = "Yoga"
//}

// MARK: - Course Workout List
struct CourseWorkoutListResponse: Codable {
    let status: Bool
    let message: String?
    let data: CourseWorkoutData?
}
struct CourseWorkoutData: Codable {
    let list: [CourseWorkoutList]?
    let count: Int?
}
struct CourseWorkoutList: Codable {
    let courseDurationID, courseID: Int?
    let dayName, description: String?
    let noOfExercise: Int?
    let calorieBurn, workoutTime: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let courseDurationExercise: [CourseWorkoutDurationExercise]?
    
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
struct CourseWorkoutDurationExercise: Codable {
    let courseDurationExerciseID, courseDurationID, videoID: Int?
    let title, description, instruction, exerciseSet: String?
    let exerciseWraps, exerciseTime: String?
    let createdAt, updatedAt: String?
    let videoDetail: CourseWorkoutVideoDetail?
    
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
//VideoDetail
struct CourseWorkoutVideoDetail: Codable {
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

// MARK: - All Batch Level list
struct AllBatchLevellistResponse: Codable {
    let status: Bool
    let message: String?
    let data: AllBatchLevellistData?
}
struct AllBatchLevellistData: Codable {
    let list: [AllBatchLevelList]?
    let count: Int?
}
struct AllBatchLevelList: Codable {
    let id: Int?
    let levelName: String?
    let status: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case levelName = "level_name"
        case status
    }
}

// MARK: - All Workout Type List
struct AllWorkoutTypeListResponse: Codable {
    let status: Bool
    let message: String?
    let data: AllWorkoutTypeListData?
}
struct AllWorkoutTypeListData: Codable {
    let list: [AllWorkoutTypeList]?
    let count: Int?
}
struct AllWorkoutTypeList: Codable {
    let id: Int?
    let workoutType: String?
    let status: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case workoutType = "workout_type"
        case status
    }
}

// MARK: - All Batch Goal List
struct AllBatchGoalListResponse: Codable {
    let status: Bool
    let message: String?
    let data: AllBatchGoalListData?
}
struct AllBatchGoalListData: Codable {
    let list: [AllBatchGoalList]?
    let count: Int?
}
struct AllBatchGoalList: Codable {
    let id: Int?
    let goalName: String?
    let status: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case goalName = "goal_name"
        case status
    }
}

// MARK: - All CoachFilter List
struct AllCoachFilterListtData: Codable {
    let status: Bool
    let message: String
    let data: CoachDataList
}

// MARK: - DataClass
struct CoachDataList: Codable {
    let experiences: [Experience]
    let workouttypes: [Workouttype]
}

// MARK: - Experience
struct Experience: Codable {
    let id: Int
    let experience: String
}

// MARK: - Workouttype
struct Workouttype: Codable {
    let id: Int
    let workoutType: String
    let status: Int

    enum CodingKeys: String, CodingKey {
        case id
        case workoutType = "workout_type"
        case status
    }
}

// MARK: - CreateCourseOrder
struct CreateCourseOrderResponse: Codable {
    let status: Bool
    let message: String?
    let data: CreateCourseOrderData?
}
struct CreateCourseOrderData: Codable {
    let list: [CreateCourseOrderList]?
    let count: Int?
}
struct CreateCourseOrderList: Codable {
    let id: Int?
    let goalName: String?
    let status: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case goalName = "goal_name"
        case status
    }
}

// MARK: - Apply Promo Code
struct ApplyPromoCodeResponse: Codable {
    let status: Bool
    let message: String?
    let data: ApplyPromoCodeData?
}
struct ApplyPromoCodeData: Codable {
    let userID: Int?
    let courseID, promoCode, discount, subtotal: String?
    let total: Double?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case courseID = "course_id"
        case promoCode = "promo_code"
        case discount, subtotal, total
    }
}

// MARK: - Get Promocode List
struct GetPromocodeListResponse: Codable {
    let status: Bool
    let message: String?
    let data: GetPromocodeListData?
}
struct GetPromocodeListData: Codable {
    let list: [GetPromocodeList]?
    let count: Int?
}
struct GetPromocodeList: Codable {
    let id: Int?
    let promoCode, discount, discountType, createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case promoCode = "promo_code"
        case discount
        case discountType = "discount_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

//
////
////  BWorkOutModel.swift
////  Batch
////
////  Created by shashivendra sengar on 13/02/24.
////
//
//import Foundation
//
//// MARK: Coach List
struct WorkOutMotivatorModel: Codable {
    let status: Bool?
    let message: String?
    let data: [WorkOutMotivator]?
}

struct WorkOutMotivator: Codable {
    let id, userType: Int?
    let name, email: String?
    let profilePhotoPath: String?
    let fname, lname, phone: String?
    let dob, gender, userStatus, deviceToken: String?
    let verificationCode: String?
    let website: String?
    let currency: String?
    let emailVerifiedAt, avatar, createdAt: String?
    let updatedAt: String?
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
        case website, currency
        case emailVerifiedAt = "email_verified_at"
        case avatar
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case lastLoginAt = "last_login_at"
        case lastLoginIP = "last_login_ip"
    }
}
//
////MARK:-  Course Model
//
//
struct CourseModel: Codable {
    let status: Bool?
    let message: String?
    let data: CourseData?
}
//
//struct CourseData: Codable {
//    let list: [CourseDataList]?
//    let count: Int?
//}
//
//struct CourseDataList: Codable {
//    let courseID, userID: Int?
//    let courseName: String?
//    let courseImage, coursePromoVideo: String?
//    let courseRepetition, courseValidity, description: String?
//    let perDayWorkout, weightRequired, coursePrice: String?
//    let discountPrice: String?
//    let duration: String?
//    let courseLevel: CourseLevel?
//    let status: Int?
//    let createdAt, updatedAt: String
//    let workoutType: [WorkoutTypeElement]?
//    let coachDetail: CoachDetail?
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
//        case workoutType = "workout_type"
//        case coachDetail = "coach_detail"
//    }
//}
//
//struct CoachDetail: Codable {
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
//struct CourseLevel: Codable {
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
//struct WorkoutTypeElement: Codable {
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
//struct Workoutdetail: Codable {
//    let id: Int?
//    let workoutType: WorkoutTypeEnum?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case workoutType = "workout_type"
//    }
//}
//
//enum WorkoutTypeEnum: String, Codable {
//    case pilates = "Pilates"
//    case stretching = "Stretching"
//    case yoga = "Yoga"
//}
//
//
//
//
//
//
//// MARK: - Course Workout List
//struct CourseWorkoutListModel: Codable {
//    let status: Bool
//    let message: String?
//    let data: CourseWorkoutData?
//}
//
//// MARK: - DataClass
//struct CourseWorkoutData: Codable {
//    let list: [CourseWorkoutList]?
//    let count: Int?
//}
//
//// MARK: - List
//struct CourseWorkoutList: Codable {
//    let courseDurationID, courseID: Int?
//    let dayName, description: String?
//    let noOfExercise: Int?
//    let calorieBurn, workoutTime: String?
//    let status: Int?
//    let createdAt, updatedAt: String?
//    let courseDurationExercise: [CourseWorkoutDurationExercise]?
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
//struct CourseWorkoutDurationExercise: Codable {
//    let courseDurationExerciseID, courseDurationID, videoID: Int?
//    let title, description, instruction, exerciseSet: String?
//    let exerciseWraps, exerciseTime: String?
//    let createdAt, updatedAt: String?
//    let videoDetail: CourseWorkoutVideoDetail?
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
//// MARK: - VideoDetail
//struct CourseWorkoutVideoDetail: Codable {
//    let id, userID, folderID: Int?
//    let videoTitle: String?
//    let videoDescription: String?
//    let videoID, duration, width, height: String?
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
//
//
//// MARK: - All Batch Level list
//struct AllBatchLevellistModel: Codable {
//    let status: Bool
//    let message: String?
//    let data: AllBatchLevellistData?
//}
//
//// MARK: - DataClass
//struct AllBatchLevellistData: Codable {
//    let list: [AllBatchLevelList]?
//    let count: Int?
//}
//
//// MARK: - List
//struct AllBatchLevelList: Codable {
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
//// MARK: - All Workout Type List
//struct AllWorkoutTypeListModel: Codable {
//    let status: Bool
//    let message: String?
//    let data: AllWorkoutTypeListData?
//}
//
//// MARK: - DataClass
//struct AllWorkoutTypeListData: Codable {
//    let list: [AllWorkoutTypeList]?
//    let count: Int?
//}
//
//// MARK: - List
//struct AllWorkoutTypeList: Codable {
//    let id: Int?
//    let workoutType: String?
//    let status: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case workoutType = "workout_type"
//        case status
//    }
//}
//
//// MARK: - All Batch Goal List
//struct AllBatchGoalListModel: Codable {
//    let status: Bool
//    let message: String?
//    let data: AllBatchGoalListData?
//}
//
//// MARK: - DataClass
//struct AllBatchGoalListData: Codable {
//    let list: [AllBatchGoalList]?
//    let count: Int?
//}
//
//// MARK: - List
//struct AllBatchGoalList: Codable {
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
//// MARK: - CreateCourseOrder
//struct CreateCourseOrderModel: Codable {
//    let status: Bool
//    let message: String?
//    let data: CreateCourseOrderData?
//}
//
//// MARK: - DataClass
//struct CreateCourseOrderData: Codable {
//    let list: [CreateCourseOrderList]?
//    let count: Int?
//}
//
//// MARK: - List
//struct CreateCourseOrderList: Codable {
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
//
//// MARK: - Apply Promo Code
//struct ApplyPromoCodeModel: Codable {
//    let status: Bool
//    let message: String?
//    let data: ApplyPromoCodeData?
//}
//
//// MARK: - DataClass
//struct ApplyPromoCodeData: Codable {
//    let userID: Int?
//    let courseID, promoCode, discount, subtotal: String?
//    let total: Double?
//
//    enum CodingKeys: String, CodingKey {
//        case userID = "user_id"
//        case courseID = "course_id"
//        case promoCode = "promo_code"
//        case discount, subtotal, total
//    }
//}
//
//
//// MARK: - Get Promocode List
//struct GetPromocodeListModel: Codable {
//    let status: Bool
//    let message: String?
//    let data: GetPromocodeListData?
//}
//
//// MARK: - DataClass
//struct GetPromocodeListData: Codable {
//    let list: [GetPromocodeList]?
//    let count: Int?
//}
//
//// MARK: - List
//struct GetPromocodeList: Codable {
//    let id: Int?
//    let promoCode, discount, discountType, createdAt: String?
//    let updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case promoCode = "promo_code"
//        case discount
//        case discountType = "discount_type"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}

//MARK: - Coach List Response
//struct CoachListResponse: Codable {
//    let status: Bool?
//    let message: String?
//    let data: [CoachListData]?
//}
//struct CoachListData: Codable {
//    let id, userType: Int?
//    let name, email: String?
//    let profilePhotoPath: String?
//    let fname, lname, phone: String?
//    let dob, gender, userStatus, deviceToken: String?
//    let verificationCode: String?
//    let website: String?
//    let currency: String?
//    let emailVerifiedAt, avatar, createdAt: String?
//    let updatedAt: String?
//    let lastLoginAt, lastLoginIP: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userType = "user_type"
//        case name, email
//        case profilePhotoPath = "profile_photo_path"
//        case fname, lname, phone, dob, gender
//        case userStatus = "user_status"
//        case deviceToken = "device_token"
//        case verificationCode = "verification_code"
//        case website, currency
//        case emailVerifiedAt = "email_verified_at"
//        case avatar
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case lastLoginAt = "last_login_at"
//        case lastLoginIP = "last_login_ip"
//    }
//}




// MARK: - Welcome
struct CoachListResponse: Codable {
    let status: Bool
    let message: String?
    let data: [CoachListData]?
}

// MARK: - Datum
struct CoachListData: Codable {
    let id, userType: Int?
    let name, email: String?
    let profilePhotoPath: String?
    let fname, lname, phone: String?
    let dob, gender, userStatus, deviceToken: String?
    let verificationCode: String?
    let website: String?
    let currency: String?
    let experience: Int?
    let emailVerifiedAt, avatar, createdAt: String?
    let updatedAt: String?
    let lastLoginAt, lastLoginIP: String?
    let followersCount, youFollowedCount: Int
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

//// MARK: - WorkoutType
//struct WorkoutType: Codable {
//    let id, userID, workoutType: Int
//    let createdAt, updatedAt: JSONNull?
//    let workoutdetail: Workoutdetail
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case workoutType = "workout_type"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case workoutdetail
//    }
//}
//
//// MARK: - Workoutdetail
//struct Workoutdetail: Codable {
//    let id: Int
//    let workoutType: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case workoutType = "workout_type"
//    }
//}
