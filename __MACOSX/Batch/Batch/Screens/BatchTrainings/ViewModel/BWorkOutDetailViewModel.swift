//
//  BWorkOutDetailViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct BWorkOutDetailViewModel {
    
    func courseDetail(requestUrl: String, onSuccess:@escaping(CourseDetailWSResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = BWorkOutResource()
        bWOResource.getCourseDetail(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
