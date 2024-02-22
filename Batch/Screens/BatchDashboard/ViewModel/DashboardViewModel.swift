//
//  TrainingFilterViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct DashboardViewModel {
    func allCourseSubscribeList(requestUrl: String, onSuccess:@escaping(DashboardWOResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = DashboardResource()
        bWOResource.allCourseSubscribeList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
