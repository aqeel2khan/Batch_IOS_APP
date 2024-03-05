//
//  BUserProfileVM.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation

struct BUserProfileVM{
    func getProfileDetails(onSuccess:@escaping(GetProfileResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bUserProfile = BUserProfileResource()
        bUserProfile.getProfileDetails { response in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}
