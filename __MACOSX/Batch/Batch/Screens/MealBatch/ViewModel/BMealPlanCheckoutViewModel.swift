//
//  BMealPlanCheckoutViewModel.swift
//  Batch
//
//  Created by Krupanshu Sharma on 15/03/24.
//

import Foundation

struct BMealPlanCheckoutViewModel {
        
    func getDeliveryTimeSlots(requestUrl: String, onSuccess:@escaping(DeliveryTimeSlotsResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bMealResource = BMealPlanCheckoutResource()
        bMealResource.deliveryTimeSlots(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func getDeliveryArrivingSlots(requestUrl: String, onSuccess:@escaping(DeliveryArrivingOptionsResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bMealResource = BMealPlanCheckoutResource()
        bMealResource.deliveryArrivingOptions(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func getDeliveryDropOffSlots(requestUrl: String, onSuccess:@escaping(DeliveryDropOffOptionsResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bMealResource = BMealPlanCheckoutResource()
        bMealResource.deliveryDropOffOptions(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
