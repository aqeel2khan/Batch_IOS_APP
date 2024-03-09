//
//  GoalModel.swift
//  Batch
//
//  Created by Hari Mohan on 09/03/24.
//


import Foundation

// MARK: - Welcome
struct GoalListResponse: Codable {
    let status: Bool?
    let message: String?
    let data: GoalListData?
}

// MARK: - DataClass
struct GoalListData: Codable {
    let data: [QuestionGoal]?
    let status: String?
}

// MARK: - Datum
struct QuestionGoal: Codable {
    let id: Int?
    let name: String?
}
