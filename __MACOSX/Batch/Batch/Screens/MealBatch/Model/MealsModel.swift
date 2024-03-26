
import Foundation

// MARK: - MealsModel
struct MealsListResponse: Codable {
    let status: Bool?
    let message: String?
    let data: MealsData?
}

// MARK: - DataClass
struct MealsData: Codable {
    let data: [Meals]?
    let status: String?
    let recordsTotal: Int?
}

// MARK: - Datum
struct Meals: Codable {
    let id, restaurantID, batchID, goalID: Int?
    let name, nameAr, price, duration: String?
    let discount: Int?
    let description, descriptionAr: String?
    let status: Int?
    let createdAt, updatedAt: String?
    let avgCalPerDay: String?
    let mealCount: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id
        case restaurantID = "restaurant_id"
        case batchID = "batch_id"
        case goalID = "goal_id"
        case name
        case nameAr = "name_ar"
        case price, duration, discount, description
        case descriptionAr = "description_ar"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case avgCalPerDay = "avg_cal_per_day"
        case mealCount = "meal_count"
        case image = "image"
    }
}
