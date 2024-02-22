//
//  BWorkOutResource.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct DashboardResource {
    // All Batch Level List
    func allCourseSubscribeList(urlStr:String, onSuccess:@escaping(DashboardWOResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let coachDetailContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: coachDetailContentUrl, method: .postWORequest)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: true, resultType: DashboardWOResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
}
