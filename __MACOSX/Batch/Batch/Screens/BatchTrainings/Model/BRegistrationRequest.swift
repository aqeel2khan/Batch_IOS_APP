//
//  BRegistrationRequest.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/02/24.
//

import Foundation

// MARK: - Welcome
struct BRegistrationRequest: Codable {
    let email, password, mobile, name, device_token: String
}
