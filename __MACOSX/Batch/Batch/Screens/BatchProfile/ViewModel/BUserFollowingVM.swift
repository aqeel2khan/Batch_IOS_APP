//
//  BAccountVM.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation


struct BUserFollowingVM{
    
    func getFolowingDetails(onSuccess:@escaping(GetFollowingResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bUserFollwing = BUserFollowingResource()
        bUserFollwing.getFollowingDetails{ response in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func followUnfollowApi(requestUrl: String, onSuccess:@escaping(MotivatorFollowUnFollowResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = BUserFollowingResource()
        
        bWOResource.followUnfollowApiCall(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
