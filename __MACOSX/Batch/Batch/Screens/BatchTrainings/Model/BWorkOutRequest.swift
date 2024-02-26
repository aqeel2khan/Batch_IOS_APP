//
//  BWorkOutRequest.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 24/02/24.
//

import Foundation


struct CourseFilterRequest: Codable {
    let courseLevel, workoutTypeID, goalID: String?

    enum CodingKeys: String, CodingKey {
        case courseLevel = "course_level"
        case workoutTypeID = "workout_type_id"
        case goalID = "goal_id"
    }
}

struct MotivatorFilterRequest: Codable {
    let keyword, experience, workoutType: String?

    enum CodingKeys: String, CodingKey {
        case keyword, experience
        case workoutType = "workout_type"
    }
}
