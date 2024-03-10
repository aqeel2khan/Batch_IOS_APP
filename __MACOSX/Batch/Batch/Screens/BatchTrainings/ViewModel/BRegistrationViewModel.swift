//
//  BRegistrationViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 23/02/24.
//

import Foundation

struct BRegistrationViewModel {
    
    func registrationApi(request: BRegistrationRequest, onSuccess:@escaping(BRegistrationResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let signUpValidation = SignUpValidation()
        let result = signUpValidation.validate(request: request)
        
        if result.success{
            let bWOResource = BWorkOutResource()
            bWOResource.registrationResourse(request: request) { (response) in
                onSuccess(response)
            } onError: { (error) in
                onError(error)
            }
        }
        else {
            onError(result.error!)
        }
    }
}
