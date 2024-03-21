//
//  BatchLoginRequest.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 21/02/24.
//

import Foundation

// MARK: - Welcome
struct BatchLoginRequest: Codable {
    let email, password, deviceToken: String

    enum CodingKeys: String, CodingKey {
        case email, password
        case deviceToken = "device_token"
    }
}


// MARK: - Welcome
struct BatchFCMRequest: Codable {
    let deviceToken: String

    enum CodingKeys: String, CodingKey {
        case deviceToken = "device_token"
    }
}
