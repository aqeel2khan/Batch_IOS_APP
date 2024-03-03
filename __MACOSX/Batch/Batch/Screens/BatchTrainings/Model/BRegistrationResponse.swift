//
//  BRegistrationResponse.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/02/24.
//

import Foundation

// MARK: - Welcome
struct BRegistrationResponse: Codable {
    let status: Bool?
    let message: String?
    let data: BRegistrationData?
    let token: String?
}

// MARK: - DataClass
struct BRegistrationData: Codable {
    let id: Int?
    let name, mobile, email: String?
    let dob, gender: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, mobile, email, dob, gender
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
