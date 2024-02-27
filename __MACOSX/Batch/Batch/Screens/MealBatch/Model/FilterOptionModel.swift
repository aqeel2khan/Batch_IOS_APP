
import Foundation

struct FilterOptionResponse: Codable {
    let status: Bool?
    let message: String?
    let data: FilterOptionData?
}

// MARK: - WelcomeData
struct FilterOptionData: Codable {
    let data: FilterData?
    let status: String?
}

// MARK: - DataData
struct FilterData: Codable {
    let mealCalories: [MealCalory]?
    let batchGoals: [BatchGoal]?
    let mealTags: [MealTags]?

    enum CodingKeys: String, CodingKey {
        case mealCalories = "meal_calories"
        case batchGoals = "batch_goals"
        case mealTags = "meal_tags"
    }
}

// MARK: - BatchGoal
struct BatchGoal: Codable {
    let id: Int?
    let name, nameAr: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
    }
}

// MARK: - MealCalory
struct MealCalory: Codable {
    let id, fromValue, toValue: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case fromValue = "from_value"
        case toValue = "to_value"
    }
}

// MARK: - MealTags
struct MealTags: Codable {
    let id: Int?
    let name, nameAr: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
    }
}
