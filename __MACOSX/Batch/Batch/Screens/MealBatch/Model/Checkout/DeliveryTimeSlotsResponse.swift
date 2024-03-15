//
//  DeliveryTimeSlotsResponse.swift
//  Batch
//
//  Created by Krupanshu Sharma on 15/03/24.
//

import Foundation

// MARK: - DeliveryTimeSlotsResponse
struct DeliveryTimeSlotsResponse: Codable {
    let status: Bool
    let message: String
    let data: DeliveryTimeSlotsData?
}

// MARK: - DataClass
struct DeliveryTimeSlotsData: Codable {
    let data: [DeliveryTimeSlots]?
    let status: String
}

// MARK: - Datum
struct DeliveryTimeSlots: Codable {
    let id: Int
    let timeSlot: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case timeSlot = "time_slot"
    }
}
