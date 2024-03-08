//
//  BUserFollowingResource.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation


struct BUserFollowingResource {
    func getFollowingDetails(onSuccess:@escaping(GetFollowingResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let huRequest = HURequest(url: URL(string: API.getFollowingDetail)!, method: .get)
        HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: GetFollowingResponse.self) { (result) in
            switch result{
            case .success(let response):
                onSuccess(response!)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func followUnfollowApiCall(urlStr:String, onSuccess:@escaping(MotivatorFollowUnFollowResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: MotivatorFollowUnFollowResponse
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
