//
//  BWorkOutViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct BMealViewModel {
    
    // Course List
    func mealList(requestUrl: String, onSuccess:@escaping(MealsListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.mealList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
}
