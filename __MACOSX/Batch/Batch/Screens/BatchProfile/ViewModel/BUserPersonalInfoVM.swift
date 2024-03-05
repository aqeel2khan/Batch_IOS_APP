//
//  BUserPersonalInfoVM.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation


struct BUserPersonalInfoVM{
    func getProfileDetails(onSuccess:@escaping(GetProfileResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bUserProfile = BUserPersonalInfoResource()
        bUserProfile.getPersonalInfo { response in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
    
    func updatePersonalInfo(request: UpdateProfileRequest, onSuccess:@escaping(UpdateProfileResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let userProfileValidation = UserProfileValidation()
        let result = userProfileValidation.validate(request: request)
        if result.success{
            let bUserProfile = BUserPersonalInfoResource()
            bUserProfile.updateProfileInfo(request: request){ (response) in
                onSuccess(response)
            } onError: { (error) in
                onError(error)
            }
        }
        else
        {
            onError(result.error!)
        }
        
    }
    
    
}
