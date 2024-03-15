//
//  BMealPlanCheckoutResource.swift
//  Batch
//
//  Created by Krupanshu Sharma on 15/03/24.
//

import Foundation

struct BMealPlanCheckoutResource {
    
    // Get Delivery Time list Api  //1
    func deliveryTimeSlots(urlStr:String, onSuccess:@escaping(DeliveryTimeSlotsResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .get)
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: DeliveryTimeSlotsResponse
            .self) { (result) in
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    func deliveryArrivingOptions(urlStr:String, onSuccess:@escaping(DeliveryArrivingOptionsResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .get)
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: DeliveryArrivingOptionsResponse
            .self) { (result) in
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    func deliveryDropOffOptions(urlStr:String, onSuccess:@escaping(DeliveryDropOffOptionsResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .get)
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: DeliveryDropOffOptionsResponse
            .self) { (result) in
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }

}
