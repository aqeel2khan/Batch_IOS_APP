//
//  BUserProfileVM.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation

struct BUserProfileVM{
    let bUserProfile = BUserProfileResource()
    func getProfileDetails(onSuccess:@escaping(GetProfileResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        bUserProfile.getProfileDetails { response in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func uploadProfilePhoto(media:Media,onSuccess:@escaping(GetProfileResponse) -> Void, onError:@escaping(BatchError) -> Void){
        bUserProfile.updateProfilePhoto(mediaList: media) { response in
            onSuccess(response)
        } onError: { err in
            onError(err)
        }

        
    }
}
