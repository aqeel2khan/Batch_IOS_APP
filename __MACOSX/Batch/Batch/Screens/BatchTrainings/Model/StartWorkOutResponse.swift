//
//  StartWorkOutResponse.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 14/03/24.
//

import Foundation

// MARK: - StartWorkOutResponse
struct StartWorkOutResponse: Codable {
    let status: Bool?
    let message: String?
    let data: StartWorkOutData?
}
// MARK: - DataClass
struct StartWorkOutData: Codable {
    let userID: Int?
    let courseID, workoutID, workoutExerciseID: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case courseID = "course_id"
        case workoutID = "workout_id"
        case workoutExerciseID = "workout_exercise_id"
    }
}
