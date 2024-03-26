//
//  CityRequestResponse.swift
//  Batch
//
//  Created by Krupanshu Sharma on 26/03/24.
//

import Foundation

struct CityRequest: Codable {
    var stateId: String?
    
    enum CodingKeys: String, CodingKey {
        case stateId = "state_id"
    }
}

// MARK: - CityResponse
struct CityResponse: Codable {
    let status: Bool
    let message: String
    let data: CityData?
}

// MARK: - CityData
struct CityData: Codable {
    let data: [City]?
    let status: String
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
}
