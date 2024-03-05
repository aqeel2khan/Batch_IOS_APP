//
//  BUserLogoutResource.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation


struct BUserLogoutResource {
    func logoutUser(onSuccess:@escaping(LogoutResponse) -> Void, onError:@escaping(BatchError) -> Void){
        do {
            let huRequest = HURequest(url: URL(string: API.logout)!, method: .post)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: LogoutResponse.self) { (result) in
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
