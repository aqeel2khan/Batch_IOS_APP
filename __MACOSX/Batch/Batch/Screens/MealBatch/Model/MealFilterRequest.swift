//
//  MealFilterRequest.swift
//  Batch
//
//  Created by Krupanshu Sharma on 03/03/24.
//

import Foundation

struct MealFilterRequest: Codable {
    var caloriesFrom, caloriesTo, goalID, tagId: String?
    
    enum CodingKeys: String, CodingKey {
        case caloriesFrom = "calories_from"
        case caloriesTo = "calories_to"
        case goalID = "goal_id"
        case tagId = "tag_id"
    }
}
