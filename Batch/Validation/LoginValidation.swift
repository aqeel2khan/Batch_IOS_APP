//
//  LoginValidation.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import Foundation

struct LoginValidation {
    
    func validate(request: BatchLoginRequest) -> ValidationResult{
        
        let emptyResult = checkForEmpty(request: request)
        if emptyResult.isEmpty{
            return ValidationResult(success: false, error: emptyResult.error)
        }
        
        return ValidationResult(success: true, error: nil)
    }
    
    private func checkForEmpty(request: BatchLoginRequest) -> (isEmpty: Bool, error: RegistrationError?){
        
        if request.email.isEmpty{
            return (true, .emptyEmail)
        }
        
        if request.password.isEmpty{
            return (true, .emptyPassword)
        }
        
        return (false, nil)
    }
    
    
    
}
