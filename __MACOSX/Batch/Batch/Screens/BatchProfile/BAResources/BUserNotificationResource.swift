//
//  BUserNotificationResource.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation


struct BUserNotificationResource {
    func getUserNotifcationPrefrences(onSuccess:@escaping(GetNotificationPrefrencesResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let huRequest = HURequest(url: URL(string: API.getNotificationPrefrences)!, method: .get)
        HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: GetNotificationPrefrencesResponse.self) { (result) in
            switch result{
            case .success(let response):
                onSuccess(response!)
            case .failure(let error):
                onError(error)
            }
        }
    }
}
