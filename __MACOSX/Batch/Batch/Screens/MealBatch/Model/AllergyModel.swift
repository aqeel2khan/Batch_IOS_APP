
import Foundation

// MARK: - Welcome
struct AllergyListResponse: Codable {
    let status: Bool?
    let message: String?
    let data: AllergyData?
}

// MARK: - DataClass
struct AllergyData: Codable {
    let data: [Allergy]?
    let status: String?
}

// MARK: - Datum
struct Allergy: Codable {
    let id: Int?
    let name, icon: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case icon
    }
}
