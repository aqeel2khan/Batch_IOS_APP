//
//  StateRequestResponse.swift
//  Batch
//
//  Created by Krupanshu Sharma on 26/03/24.
//

import Foundation

struct StateRequest: Codable {
    var countryId: String?
    
    enum CodingKeys: String, CodingKey {
        case countryId = "country_id"
    }
}

// MARK: - StateResponse
struct StateResponse: Codable {
    let status: Bool
    let message: String
    let data: StateData?
}

// MARK: - DataClass
struct StateData: Codable {
    let data: [States]?
    let status: String
}

// MARK: - Datum
struct States: Codable {
    let id: Int
    let name: String
}
