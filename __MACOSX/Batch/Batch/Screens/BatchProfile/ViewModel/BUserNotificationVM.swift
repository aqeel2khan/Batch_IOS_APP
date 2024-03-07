//
//  BUserNotificationResource.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation


struct BUserNotificationVM{
    func getNotificationPrefrences(onSuccess:@escaping(GetNotificationPrefrencesResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bUserNotificationPrefrences = BUserNotificationResource()
        bUserNotificationPrefrences.getUserNotifcationPrefrences { response in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func updateNotificationInfo(request: UpdateNotificationRequest, onSuccess:@escaping(LogoutResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bUserProfile = BUserNotificationResource()
        bUserProfile.updateNotificationPrefrencesInfo(request: request){ (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
        
    }
}
