//
//  AnswerModel.swift
//  Batch
//
//  Created by Hari Mohan on 09/03/24.
//

import Foundation

struct AnswerRequest: Codable {
    let goal_id, age, height, current_weight, target_weight, workout_per_week, tag_id, allergic_id: String

    enum CodingKeys: String, CodingKey {
        case goal_id, age, height, current_weight, target_weight, workout_per_week, tag_id, allergic_id
    }
}

struct AnswerResponse: Codable {
    let status: Bool
    let message: String
    let data: AnswerData
}

// MARK: - WelcomeData
struct AnswerData: Codable {
    let data: CaloryData
    let status: String
}

// MARK: - DataData
struct CaloryData: Codable {
    let avg_cal_per_day: String

    enum CodingKeys: String, CodingKey {
        case avg_cal_per_day = "avg_cal_per_day"
    }
}
