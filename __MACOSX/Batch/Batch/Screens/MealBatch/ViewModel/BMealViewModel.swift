//
//  BWorkOutViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct BMealViewModel {
    
    func mealList(requestUrl: String, onSuccess:@escaping(MealsListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.mealList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func mealDetail(requestUrl: String, onSuccess:@escaping(MealsDetailResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.mealDetail(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func dishesList(requestUrl: String, onSuccess:@escaping(DishesListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.dishesList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
}
