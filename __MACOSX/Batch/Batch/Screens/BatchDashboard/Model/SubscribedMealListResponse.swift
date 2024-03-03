//
//  SubscribedMealListResponse.swift
//  Batch
//
//  Created by Krupanshu Sharma on 03/03/24.
//

import Foundation

struct SubscribedMealListResponse: Codable {
    let status: Bool?
    let message: String?
    let data: MealsData?
}
