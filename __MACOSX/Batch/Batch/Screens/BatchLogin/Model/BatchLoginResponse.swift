//
//  BatchLoginResponse.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 21/02/24.
//

import Foundation

// MARK: - Welcome
struct BatchLoginResponse: Codable {
    let status: Bool?
    let message: String?
    let data: BatchLoginData?
    let token: String?
}

// MARK: - DataClass
struct BatchLoginData: Codable {
    let id: Int?
    let name, mobile, email, dob: String?
    let gender, createdAt, updatedAt: String?
    let profile_photo_path: String?

    enum CodingKeys: String, CodingKey {
        case id, name, mobile, email, dob, gender
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profile_photo_path
    }
}
