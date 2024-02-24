//
//  BWorkOutMotivatorDetailViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct BWorkOutMotivatorDetailViewModel {
    
    func couchDetail(requestUrl: String, onSuccess:@escaping(CoachDetailResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = BWorkOutResource()
        bWOResource.getCoachDetail(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func coachDetailCourseList(requestUrl: String, onSuccess:@escaping(CourseWorkoutListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = BWorkOutResource()
        
        bWOResource.getCoachDetailCourseList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func motivatorCourseList(requestUrl: String, onSuccess:@escaping(motivatorCoachListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = BWorkOutResource()
        
        bWOResource.getMotivatorCourseList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }

}
