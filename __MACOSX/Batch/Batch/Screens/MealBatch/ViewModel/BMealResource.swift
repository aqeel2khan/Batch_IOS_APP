//
//  BWorkOutResource.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct BMealResource {
    
    // Meal list API with Post Request. Supports Filter.
    func applyFilterToMealList(urlStr:String, request: MealFilterRequest, onSuccess:@escaping(MealsListResponse) -> Void, onError:@escaping(BatchError) -> Void) {
        do {
            let requestBody = try JSONEncoder().encode(request)
            do {
                let decodedRequest = try JSONDecoder().decode(MealFilterRequest.self, from: requestBody)
                print(decodedRequest)
            } catch {
                print("Error decoding request body: \(error)")
            }
            let huRequest = HURequest(url: URL(string: urlStr)!, method: .post, requestBody: requestBody)
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: false, resultType: MealsListResponse.self) { (result) in
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }

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
    
    // Get Meal Detail Api  //1
    func mealDetail(urlStr:String, onSuccess:@escaping(MealsDetailResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: MealsDetailResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
   
    // Get Dishes list Api  //1
    func dishesList(urlStr:String, onSuccess:@escaping(DishesListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: DishesListResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    // Get Dishes Details Api  //1
    func dishesDetail(urlStr:String, onSuccess:@escaping(DishesDetailsResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .postWORequest)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: DishesDetailsResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    // Get Filter Option  //1
    func filterOption(urlStr:String, onSuccess:@escaping(FilterOptionResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .postWORequest)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: FilterOptionResponse
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

