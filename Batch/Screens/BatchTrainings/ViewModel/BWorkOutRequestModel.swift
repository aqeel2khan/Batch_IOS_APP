//
//  BWorkOutRequestModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

// MARK: - Add promocode request
struct PromoCodeRequest: Codable {
    let courseID, promoCode: String

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case promoCode = "promo_code"
    }
}



//MARK: - Search Request
struct SearchRequest: Codable {
    let keyword: String
}


// MARK: - Add promocode request
struct motivatorCoachListRequest: Codable {
    let coachID: String

    enum CodingKeys: String, CodingKey {
        case coachID = "coach_id"
    }
}
