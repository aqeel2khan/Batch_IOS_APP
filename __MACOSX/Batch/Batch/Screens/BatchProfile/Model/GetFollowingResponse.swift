//
//  GetFollowingResponse.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation


struct GetFollowingResponse : Codable {
    let status : Bool?
    let message : String?
    let data : [GetFollowingResponseData]?
    let error : GetFollowingResponseError?

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
        data = try values.decodeIfPresent([GetFollowingResponseData].self, forKey: .data)
        error = try values.decodeIfPresent(GetFollowingResponseError.self, forKey: .error)
    }

}

struct GetFollowingResponseData : Codable {
    let id : Int?
    let user_id : Int?
    let coach_id : Int?
    let motivator_detail : Motivator_detail?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case coach_id = "coach_id"
        case motivator_detail = "motivator_detail"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        coach_id = try values.decodeIfPresent(Int.self, forKey: .coach_id)
        motivator_detail = try values.decodeIfPresent(Motivator_detail.self, forKey: .motivator_detail)
    }

}


struct Motivator_detail : Codable {
    let id : Int?
    let name : String?
    let email : String?
    let profile_photo_path : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case email = "email"
        case profile_photo_path = "profile_photo_path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        profile_photo_path = try values.decodeIfPresent(String.self, forKey: .profile_photo_path)
    }

}


struct GetFollowingResponseError : Codable {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
    }

}
