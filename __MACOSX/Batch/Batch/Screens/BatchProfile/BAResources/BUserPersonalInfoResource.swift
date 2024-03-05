//
//  BUserPersonalInfoResource.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation




struct BUserPersonalInfoResource{
    func getPersonalInfo(onSuccess:@escaping(GetProfileResponse) -> Void, onError:@escaping(BatchError) -> Void){
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
    
    
    func updateProfileInfo(request: UpdateProfileRequest, onSuccess:@escaping(UpdateProfileResponse) -> Void, onError:@escaping(BatchError) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.updateProfileDetail)!, method: .put, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: UpdateProfileResponse.self) { (result) in
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
