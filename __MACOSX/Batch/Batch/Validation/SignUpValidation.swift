//
//  SignUpValidation.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import Foundation

struct SignUpValidation {
    
     func validate(request: BRegistrationRequest) -> ValidationResult{
     
     let result = checkForEmpty(request: request)
     if result.isEmpty{
     return ValidationResult(success: false, error: result.error)
     }
     
     return ValidationResult(success: true, error: nil)
     }
     
     private func checkForEmpty(request: BRegistrationRequest) -> (isEmpty: Bool, error: RegistrationError?){
     
     if request.name.isEmpty{
     return (true, .emptyName)
     }
     
     if request.email.isEmpty{
     return (true, .emptyEmail)
     }
     
     if request.mobile.isEmpty{
     return (true, .emptyPhoneNumber)
     }
     
     if request.password.isEmpty{
     return (true, .emptyPassword)
     }
     
     return (false, nil)
     }
    
}
