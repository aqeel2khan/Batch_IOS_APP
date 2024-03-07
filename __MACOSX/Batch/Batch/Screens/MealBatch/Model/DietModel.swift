// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct DietListResponse: Codable {
    let status: Bool
    let message: String
    let data: DietData
}

// MARK: - DataClass
struct DietData: Codable {
    let data: [Diet]
    let status: String
}

// MARK: - Datum
struct Diet: Codable {
    let id: Int
    let name, nameAr, icon: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case icon
    }
}
