//
//  TrainingFilterViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct DashboardViewModel {
    func allCourseSubscribeList(requestUrl: String, onSuccess:@escaping(DashboardWOResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = DashboardResource()
        bWOResource.allCourseSubscribeList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    // Get subscribed meal list
    func getSubscribedMealList(urlStr:String, request: SubscribedMealListRequest, onSuccess:@escaping(SubscribedMealListResponse) -> Void, onError:@escaping(BatchError) -> Void) {
        let bHomeResource = DashboardResource()
        bHomeResource.getSubscribedMealList(urlStr: urlStr, request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    // Get subscribed meal list
    func getSubscribedMealDetail(urlStr:String, request: SubscribedMealDetailRequest, onSuccess:@escaping(SubscribedMealDetailResponse) -> Void, onError:@escaping(BatchError) -> Void) {
        let bHomeResource = DashboardResource()
        bHomeResource.getSubscribedMealDetail(urlStr: urlStr, request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
