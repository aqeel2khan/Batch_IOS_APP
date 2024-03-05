//
//  UserProfileValidation.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation


struct UserProfileValidation{
    func validate(request: UpdateProfileRequest) -> ValidationResult{
        let emptyResult = checkForEmpty(request: request)
        if emptyResult.isEmpty{
            return ValidationResult(success: false, error: emptyResult.error)
        }
        return ValidationResult(success: true, error: nil)
    }
    
    
    private func checkForEmpty(request: UpdateProfileRequest) -> (isEmpty: Bool, error: RegistrationError?){
        
        if request.dob.isEmpty{
            return (true, .emptyDob)
        }
        
        if request.mobile.isEmpty{
            return (true, .emptyPhoneNumber)
        }
        
        if request.name.isEmpty{
            return (true, .emptyName)
        }
        
        if request.gender.isEmpty{
            return (true, .emptyGender)
        }
        
        return (false, nil)
    }
}
