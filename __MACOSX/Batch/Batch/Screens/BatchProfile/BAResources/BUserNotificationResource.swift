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
    
    func updateNotificationPrefrencesInfo(request: UpdateNotificationRequest, onSuccess:@escaping(LogoutResponse) -> Void, onError:@escaping(BatchError) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.updateNotifiationPrefrences)!, method: .put, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: LogoutResponse.self) { (result) in
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
