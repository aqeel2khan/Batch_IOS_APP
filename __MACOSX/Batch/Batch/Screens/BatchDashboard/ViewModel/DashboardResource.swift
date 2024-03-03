//
//  BWorkOutResource.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct DashboardResource {
    // All Batch Level List
    func allCourseSubscribeList(urlStr:String, onSuccess:@escaping(DashboardWOResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let coachDetailContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: coachDetailContentUrl, method: .postWORequest)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: true, resultType: DashboardWOResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    // Get subscribed Meal list API with Post Request.
    func getSubscribedMealList(urlStr:String, request: SubscribedMealListRequest, onSuccess:@escaping(SubscribedMealListResponse) -> Void, onError:@escaping(BatchError) -> Void) {
        do {
            let requestBody = try JSONEncoder().encode(request)
            do {
                let decodedRequest = try JSONDecoder().decode(SubscribedMealListRequest.self, from: requestBody)
                print(decodedRequest)
            } catch {
                print("Error decoding request body: \(error)")
            }
            let huRequest = HURequest(url: URL(string: urlStr)!, method: .post, requestBody: requestBody)
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: false, resultType: SubscribedMealListResponse.self) { (result) in
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

}
