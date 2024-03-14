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
    
    func topRatedMealList(requestUrl: String, onSuccess:@escaping(MealsListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.topRatedMealList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func goalList(requestUrl: String, onSuccess:@escaping(GoalListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.goalList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func dietList(requestUrl: String, onSuccess:@escaping(DietListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.dietList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func allergiesList(requestUrl: String, onSuccess:@escaping(AllergyListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.allergiesList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func questionAnswer(requestUrl: String, request: AnswerRequest, onSuccess:@escaping(AnswerResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bMealResource = BMealResource()
        bMealResource.questionAnswer(urlStr: requestUrl,  request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func getDishReviewList(requestUrl: String, onSuccess:@escaping(DishReviewListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bMealResource = BMealResource()
        bMealResource.dishReviewList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func postReviewForDish(urlStr:String, request: PostReviewRequest, onSuccess:@escaping(PostReviewResponse) -> Void, onError:@escaping(BatchError) -> Void) {
        let bMealResource = BMealResource()
        bMealResource.postReviewForDish(urlStr: urlStr, request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func checkIfMealIsSubscribed(urlStr:String, request: CheckSubscribedRequest, onSuccess:@escaping(CheckSubscribedResponse) -> Void, onError:@escaping(BatchError) -> Void) {
        let bMealResource = BMealResource()
        bMealResource.checkIsMealSubscribed(urlStr: urlStr, request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
