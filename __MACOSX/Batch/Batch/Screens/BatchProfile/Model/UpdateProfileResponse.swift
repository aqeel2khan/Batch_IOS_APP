//
//  UpdateProfileResponse.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation

struct UpdateProfileRequest: Encodable{
    let mobile: String
    let name: String
    let dob: String
    let gender: String
    
    init(mobile: String, name: String, dob: String, gender: String) {
        self.mobile = mobile
        self.name = name
        self.dob = dob
        self.gender = gender
    }
}

struct UpdateProfileResponse : Codable {
    let status : Bool?
    let message : String?
    let data : UpdateProfileResponseData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(UpdateProfileResponseData.self, forKey: .data)
    }

}


struct UpdateProfileResponseData : Codable {
    let id : Int?
    let name : String?
    let mobile : String?
    let email : String?
    let dob : String?
    let gender : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case mobile = "mobile"
        case email = "email"
        case dob = "dob"
        case gender = "gender"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
