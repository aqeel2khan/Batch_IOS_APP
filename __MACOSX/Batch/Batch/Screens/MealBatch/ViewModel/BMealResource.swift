//
//  BWorkOutResource.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct BMealResource {
    // Get Meal List Api  //1
    func mealList(urlStr:String, onSuccess:@escaping(MealsListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .postWORequest)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: MealsListResponse
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

