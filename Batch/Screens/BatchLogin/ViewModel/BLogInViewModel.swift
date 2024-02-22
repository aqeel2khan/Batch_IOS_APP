//
//  BLogInViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 21/02/24.
//

import Foundation

struct BLogInViewModel {
    
    func loginApi(request: BatchLoginRequest, onSuccess:@escaping(BatchLoginResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let loginValidation = LoginValidation()
        let result = loginValidation.validate(request: request)
        
        if result.success{
            
            let bWOResource = BLogInResource()
            bWOResource.logInApiCall(request: request) { (response) in
                onSuccess(response)
            } onError: { (error) in
                onError(error)
            }
        }
        
        
    }
    
}
