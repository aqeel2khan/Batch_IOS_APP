
import Foundation

struct DishesDetailsResponse: Codable {
    let status: Bool?
    let message: String?
    let data: DishDetailData?
}

struct DishDetailData: Codable {
    let data: DishDetail?
    let status: String?
}

// MARK: - DataData
struct DishDetail: Codable {
    let id, restaurantID: Int?
    let name, nameAr, description, descriptionAr: String?
    let categoryID, isVegetarian, status: Int?
    let avgPreparationTime: String?
    let orderInMenu: Int?
    let price: String?
    let createdAt: String?
    let updatedAt: String?
    let nutritionDetails: [NutritionDetail]?

    enum CodingKeys: String, CodingKey {
        case id
        case restaurantID = "restaurant_id"
        case name
        case nameAr = "name_ar"
        case description
        case descriptionAr = "description_ar"
        case categoryID = "category_id"
        case isVegetarian = "is_vegetarian"
        case status
        case avgPreparationTime = "avg_preparation_time"
        case orderInMenu = "order_in_menu"
        case price
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case nutritionDetails = "nutrition_details"
    }
}

// MARK: - NutritionDetail
struct NutritionDetail: Codable {
    let nutrientID: Int?
    let nutrientName, value: String?
    let nutrientNameAr: String?

    enum CodingKeys: String, CodingKey {
        case nutrientID = "nutrient_id"
        case nutrientName = "nutrient_name"
        case value
        case nutrientNameAr = "nutrient_name_ar"
    }
}

