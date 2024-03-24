//
//  MealSubscriptionManager.swift
//  Batch
//
//  Created by Krupanshu Sharma on 16/03/24.
//

import Foundation

class MealSubscriptionManager {
    static let shared = MealSubscriptionManager()
    
    // Properties for SubscriptionRequest
    var userId: Int?
    var mealId: Int?
    var subtotal: String?
    var discount: String?
    var tax: Int?
    var total: String?
    var paymentType: String?
    var transactionId: String?
    var paymentStatus: String?
    var startDate: String?
    var duration: String?
    var latitude: String?
    var longitude: String?
    var area: String?
    var block: String?
    var house: String?
    var street: String?
    var addressType: String?
    var deliveryTime: String?
    var deliveryArriving: String?
    var deliveryDropoff: String?
    var deliveryTimeId: Int?
    var deliveryArrivingId: Int?
    var deliveryDropoffId: Int?
    var city: String?
    var cityId: String?
    var state: String?
    var stateId: String?

    
    private init() {}
    
    // Function to reset all properties
    func reset() {
        userId = nil
        mealId = nil
        subtotal = nil
        discount = nil
        tax = nil
        total = nil
        paymentType = nil
        transactionId = nil
        paymentStatus = nil
        startDate = nil
        duration = nil
        latitude = nil
        longitude = nil
        area = nil
        block = nil
        house = nil
        street = nil
        addressType = nil
        deliveryTime = nil
        deliveryArriving = nil
        deliveryDropoff = nil
        deliveryTimeId = nil
        deliveryArrivingId = nil
        deliveryDropoffId = nil
        city = nil
        cityId = nil
        state = nil
        stateId = nil
    }
    
    func createSubscriptionRequest() -> SubscriptionRequest? {
        guard let userId = userId,
              let mealId = mealId,
              let subtotal = subtotal,
              let discount = discount,
              let tax = tax,
              let total = total,
              let paymentType = paymentType,
              let transactionId = transactionId,
              let paymentStatus = paymentStatus,
              let startDate = startDate,
              let duration = duration,
              let latitude = latitude,
              let longitude = longitude,
              let area = area,
              let block = block,
              let house = house,
              let street = street,
              let addressType = addressType,
              let deliveryTime = deliveryTime,
              let deliveryArriving = deliveryArriving,
              let deliveryDropoff = deliveryDropoff,
              let deliveryTimeId = deliveryTimeId,
              let deliveryArrivingId = deliveryArrivingId,
              let deliveryDropoffId = deliveryDropoffId,
              let addressCity = city,
              let addressCityId = cityId,
              let addressState = state,
              let addressStateId = stateId else {
            return nil
        }
        
        return SubscriptionRequest(userId: userId,
                                   mealId: mealId,
                                   subtotal: subtotal,
                                   discount: discount,
                                   tax: tax,
                                   total: total,
                                   paymentType: paymentType,
                                   transactionId: transactionId,
                                   paymentStatus: paymentStatus,
                                   startDate: startDate,
                                   duration: duration,
                                   latitude: latitude,
                                   longitude: longitude,
                                   area: area,
                                   block: block,
                                   house: house,
                                   street: street,
                                   addressType: addressType,
                                   deliveryTime: deliveryTime,
                                   deliveryArriving: deliveryArriving,
                                   deliveryDropoff: deliveryDropoff,
                                   deliveryTimeId: deliveryTimeId,
                                   deliveryArrivingId: deliveryArrivingId,
                                   deliveryDropoffId: deliveryDropoffId,
                                   addressCity: addressCity,
                                   addressCityId: addressCityId,
                                   addressState: addressState,
                                   addressStateId: addressStateId)
    }

}
