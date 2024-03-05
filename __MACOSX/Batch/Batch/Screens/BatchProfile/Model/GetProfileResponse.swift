// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getProfileResponse = try? JSONDecoder().decode(GetProfileResponse.self, from: jsonData)

import Foundation

struct GetProfileResponse : Codable {
    let status : Bool?
    let message : String?
    let data : GetProfileResponseData?
    let error : GetProfileResponseError?

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
        data = try values.decodeIfPresent(GetProfileResponseData.self, forKey: .data)
        error = try values.decodeIfPresent(GetProfileResponseError.self, forKey: .error)
    }

}

struct GetProfileResponseData : Codable {
    let id : Int?
    let user_type : Int?
    let name : String?
    let email : String?
    let profile_photo_path : String?
    var fname : String?
    let lname : String?
    let phone : String?
    let dob : String?
    let gender : String?
    let user_status : Int?
    let device_token : String?
    let verification_code : String?
    let website : String?
    let currency : String?
    let experience : String?
    let email_verified_at : String?
    let avatar : String?
    let created_at : String?
    let updated_at : String?
    let last_login_at : String?
    let last_login_ip : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_type = "user_type"
        case name = "name"
        case email = "email"
        case profile_photo_path = "profile_photo_path"
        case fname = "fname"
        case lname = "lname"
        case phone = "phone"
        case dob = "dob"
        case gender = "gender"
        case user_status = "user_status"
        case device_token = "device_token"
        case verification_code = "verification_code"
        case website = "website"
        case currency = "currency"
        case experience = "experience"
        case email_verified_at = "email_verified_at"
        case avatar = "avatar"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case last_login_at = "last_login_at"
        case last_login_ip = "last_login_ip"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_type = try values.decodeIfPresent(Int.self, forKey: .user_type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        profile_photo_path = try values.decodeIfPresent(String.self, forKey: .profile_photo_path)
        fname = try values.decodeIfPresent(String.self, forKey: .fname)
        lname = try values.decodeIfPresent(String.self, forKey: .lname)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        user_status = try values.decodeIfPresent(Int.self, forKey: .user_status)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        verification_code = try values.decodeIfPresent(String.self, forKey: .verification_code)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        experience = try values.decodeIfPresent(String.self, forKey: .experience)
        email_verified_at = try values.decodeIfPresent(String.self, forKey: .email_verified_at)
        avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        last_login_at = try values.decodeIfPresent(String.self, forKey: .last_login_at)
        last_login_ip = try values.decodeIfPresent(String.self, forKey: .last_login_ip)
    }

}



struct GetProfileResponseError : Codable {

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
    }

}
