//
//  DeliveryArrivingOptionsResponse.swift
//  Batch
//
//  Created by Krupanshu Sharma on 15/03/24.
//

import Foundation

// MARK: - DeliveryTimeSlotsResponse
struct DeliveryArrivingOptionsResponse: Codable {
    let status: Bool
    let message: String
    let data: DeliveryArrivingOptionsData?
}

// MARK: - DataClass
struct DeliveryArrivingOptionsData: Codable {
    let data: [DeliveryArrivingOption]?
    let status: String
}

// MARK: - Datum
struct DeliveryArrivingOption: Codable {
    let id: Int
    let options: String
}
