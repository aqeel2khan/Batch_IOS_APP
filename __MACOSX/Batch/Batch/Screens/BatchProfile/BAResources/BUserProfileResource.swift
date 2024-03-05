//
//  BUserProfileResource.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation

struct BUserProfileResource{
    func getProfileDetails(onSuccess:@escaping(GetProfileResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let huRequest = HURequest(url: URL(string: API.getProfileDetail)!, method: .get)
        HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: GetProfileResponse.self) { (result) in
            switch result{
            case .success(let response):
                onSuccess(response!)
            case .failure(let error):
                onError(error)
            }
        }
    }
}
