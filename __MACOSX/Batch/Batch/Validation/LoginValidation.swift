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
        let validationResult = checkForValidData(request: request)
        if validationResult.isValid == false{
            return ValidationResult(success: false, error: validationResult.error)
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
    
    private func checkForValidData(request: BatchLoginRequest) -> (isValid: Bool, error: RegistrationError?) {
        
        if !request.email.isValidEmail(){
            return (false, RegistrationError.invalidEmail)
        }
        
        if !request.password.isValidPassword(){
            return (false, RegistrationError.invalidPassword)
        }
        return (true, nil)
    }
}
