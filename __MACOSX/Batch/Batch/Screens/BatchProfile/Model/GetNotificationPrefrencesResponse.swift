//
//  GetNotificationPrefrencesResponse.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation




struct GetNotificationPrefrencesResponse : Codable {
    let status : Bool?
    let message : String?
    let data : GetNotificationPrefrencesResponseData?
    let error : GetNotificationPrefrencesResponseError?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
        case error = "error"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(GetNotificationPrefrencesResponseData.self, forKey: .data)
        error = try values.decodeIfPresent(GetNotificationPrefrencesResponseError.self, forKey: .error)
    }

}

struct GetNotificationPrefrencesResponseData : Codable {
    let id : Int?
    let user_id : Int?
    let all : Int?
    let training : Int?
    let live_stream : Int?
    let meal_plan : Int?
    let delivery : Int?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case all = "all"
        case training = "training"
        case live_stream = "live_stream"
        case meal_plan = "meal_plan"
        case delivery = "delivery"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        all = try values.decodeIfPresent(Int.self, forKey: .all)
        training = try values.decodeIfPresent(Int.self, forKey: .training)
        live_stream = try values.decodeIfPresent(Int.self, forKey: .live_stream)
        meal_plan = try values.decodeIfPresent(Int.self, forKey: .meal_plan)
        delivery = try values.decodeIfPresent(Int.self, forKey: .delivery)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}

struct GetNotificationPrefrencesResponseError : Codable {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
    }

}
