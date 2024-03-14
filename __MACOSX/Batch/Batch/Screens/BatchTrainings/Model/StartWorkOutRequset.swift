//
//  StartWorkOutRequset.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 14/03/24.
//

import Foundation

// MARK: - StartWorkOutRequset
struct StartWorkOutRequset: Codable {
    let courseID, workoutID, workoutExerciseID, exerciseStatus: String

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case workoutID = "workout_id"
        case workoutExerciseID = "workout_exercise_id"
        case exerciseStatus = "exercise_status"
    }
}
