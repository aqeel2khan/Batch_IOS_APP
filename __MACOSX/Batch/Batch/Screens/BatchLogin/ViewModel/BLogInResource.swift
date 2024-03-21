//
//  BLogInResource.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 22/02/24.
//

import Foundation

struct BLogInResource {
    
    func logInApiCall(request: BatchLoginRequest, onSuccess:@escaping(BatchLoginResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.logIn)!, method: .post, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: false, resultType: BatchLoginResponse.self) { (result) in
                switch result{
                    
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
    
    func fcmApi(request: BatchFCMRequest, onSuccess:@escaping(BatchFCMResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.updateFCM)!, method: .put, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: false, resultType: BatchFCMResponse.self) { (result) in
                switch result{
                    
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
    
}
