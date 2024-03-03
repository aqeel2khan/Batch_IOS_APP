//
//  BWorkOutViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct BMealViewModel {
    
    func applyFilterToMealList(urlStr:String, request: MealFilterRequest, onSuccess:@escaping(MealsListResponse) -> Void, onError:@escaping(BatchError) -> Void) {
        let bMealResource = BMealResource()
        bMealResource.applyFilterToMealList(urlStr: urlStr, request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }

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
    
    
    func dishesDetail(requestUrl: String, onSuccess:@escaping(DishesDetailsResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.dishesDetail(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func filterOption(requestUrl: String, onSuccess:@escaping(FilterOptionResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.filterOption(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
