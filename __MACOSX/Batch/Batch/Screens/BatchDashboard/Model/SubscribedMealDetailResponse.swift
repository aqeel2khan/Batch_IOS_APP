//
//  SubscribedMealDetailResponse.swift
//  Batch
//
//  Created by Krupanshu Sharma on 03/03/24.
//

import Foundation

// MARK: - SubscribedMealDetailResponse
struct SubscribedMealDetailResponse: Codable {
    let status: Bool
    let message: String
    let data: SubscribedMealDetailResponseData?
}

// MARK: - SubscribedMealDetailResponseData
struct SubscribedMealDetailResponseData: Codable {
    let data: SubscribedMealDetails?
    let status: String
}

// MARK: - DataData
struct SubscribedMealDetails: Codable {
    let mealDetails: SubscribedMealDetail
    let subscribeDetail: SubscribeDetail
    
    enum CodingKeys: String, CodingKey {
        case mealDetails = "meal_details"
        case subscribeDetail = "subscribe_detail"
    }
}

// MARK: - MealDetails
struct SubscribedMealDetail: Codable {
    let name, nameAr, price, duration: String
    let discount: Int
    let description, descriptionAr, avgCalPerDay, mealType: String
    let mealCount, snackCount: Int
    let categoryList: [CategoryList]
    
    enum CodingKeys: String, CodingKey {
        case name
        case nameAr = "name_ar"
        case price, duration, discount, description
        case descriptionAr = "description_ar"
        case avgCalPerDay = "avg_cal_per_day"
        case mealType = "meal_type"
        case mealCount = "meal_count"
        case snackCount = "snack_count"
        case categoryList = "category_list"
    }
}

// MARK: - SubscribeDetail
struct SubscribeDetail: Codable {
    let subscribedID: String
    let selectedDuration: Int
    let startDate, endDate: String
    let daysDishes: [String: [String: [String: DaysDish]]]
    
    enum CodingKeys: String, CodingKey {
        case subscribedID = "subscribed_id"
        case selectedDuration = "selected_duration"
        case startDate = "start_date"
        case endDate = "end_date"
        case daysDishes = "days_dishes"
    }
}

// MARK: - DaysDish
struct DaysDish: Codable {
    let dishID: Int
    let dishName, dishImage: String
    let dishCategory, month, day, selected: Int
    
    enum CodingKeys: String, CodingKey {
        case dishID = "dish_id"
        case dishName = "dish_name"
        case dishImage = "dish_image"
        case dishCategory = "dish_category"
        case month, day, selected
    }
}

struct DateEntry {
    let month: Int
    let day: Int
    let dayName: String
    let dayOfMonth: String
    let date: Date
    var dishes: [DaysDish]? = []
}
