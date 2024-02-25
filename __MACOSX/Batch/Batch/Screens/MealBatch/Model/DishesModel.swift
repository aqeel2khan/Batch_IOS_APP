
import Foundation

// MARK: - Welcome
struct DishesListResponse: Codable {
    let status: Bool?
    let message: String?
    let data: DishesData?
}

// MARK: - DataClass
struct DishesData: Codable {
    let data: [Dishes]?
    let status: String?
}

// MARK: - Datum
struct Dishes: Codable {
    let categoryID: Int?
    let name, nameAr, description, descriptionAr: String?
    let price: String?
    let mealID, dishID, orderInMenu: Int?
    let avgPreparationTime: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case name
        case nameAr = "name_ar"
        case description
        case descriptionAr = "description_ar"
        case price
        case mealID = "meal_id"
        case dishID = "dish_id"
        case orderInMenu = "order_in_menu"
        case avgPreparationTime = "avg_preparation_time"
    }
}
