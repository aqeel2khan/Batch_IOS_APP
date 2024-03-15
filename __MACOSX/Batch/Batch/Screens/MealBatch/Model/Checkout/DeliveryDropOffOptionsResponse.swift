//
//  DeliveryDropOffOptionsResponse.swift
//  Batch
//
//  Created by Krupanshu Sharma on 15/03/24.
//

import Foundation

// MARK: - DeliveryDropOffOptionsResponse
struct DeliveryDropOffOptionsResponse: Codable {
    let status: Bool
    let message: String
    let data: DeliveryDropOffOptionData
}

// MARK: - DataClass
struct DeliveryDropOffOptionData: Codable {
    let data: [DeliveryDropOffOption]
    let status: String
}

// MARK: - Datum
struct DeliveryDropOffOption: Codable {
    let id: Int
    let options: String
}
