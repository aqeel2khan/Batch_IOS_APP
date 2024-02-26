
import Foundation

struct MealsDetailResponse: Codable {
    let status: Bool?
    let message: String?
    let data: MealsDetailData?
}

// MARK: - WelcomeData
struct MealsDetailData: Codable {
    let data: DataData?
    let status: String?
}

// MARK: - DataData
struct DataData: Codable {
    let name, nameAr, price, duration: String?
    let discount: Int?
    let description, descriptionAr, avgCalPerDay, mealType: String?
    let mealCount: Int?
    let categoryList: [CategoryList]?

    enum CodingKeys: String, CodingKey {
        case name
        case nameAr = "name_ar"
        case price, duration, discount, description
        case descriptionAr = "description_ar"
        case avgCalPerDay = "avg_cal_per_day"
        case mealType = "meal_type"
        case mealCount = "meal_count"
        case categoryList = "category_list"
    }
}

// MARK: - CategoryList
struct CategoryList: Codable {
    let categoryID: Int?
    let categoryName: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
    }
}
