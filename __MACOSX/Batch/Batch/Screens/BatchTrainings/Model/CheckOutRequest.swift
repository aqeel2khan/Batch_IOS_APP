//
//  CheckOutRequest.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 24/02/24.
//

import Foundation

// MARK: - Welcome
struct CreateCourseOrderRequest: Codable {
    let courseID, subtotal, discount, total: Int
    let paymentType: String
    let transactionID: String
    let paymentStatus: String

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case subtotal, discount, total
        case paymentType = "payment_type"
        case transactionID = "transaction_id"
        case paymentStatus = "payment_status"
    }
}
