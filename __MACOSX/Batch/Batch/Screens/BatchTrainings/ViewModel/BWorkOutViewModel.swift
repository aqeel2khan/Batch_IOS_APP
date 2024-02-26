//
//  BWorkOutViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct BWorkOutViewModel {
    
    // Course List
    func courseList(requestUrl: String, onSuccess:@escaping(CourseResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bWOResource = BWorkOutResource()
        bWOResource.getCourse(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    // Coach List
    func coachList(requestUrl: String, onSuccess:@escaping(CoachListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bWOResource = BWorkOutResource()
        
        bWOResource.getCoach(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    // Coach List search
    func coachListWithSearch(request: SearchRequest, onSuccess:@escaping(CoachListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        
        let bWOResource = BWorkOutResource()
        
        bWOResource.getCoachWithSearch(request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
        
    }
    
    
    
    func applyCourseFilter(request: CourseFilterRequest, onSuccess:@escaping(CourseResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
            let bWorkOutResource = BWorkOutResource()
        bWorkOutResource.applyCourseFilterApiCall(request: request) { (response) in
                onSuccess(response)
            } onError: { (error) in
                onError(error)
            }
    }
    
    
    func applyCoachFilter(request: MotivatorFilterRequest, onSuccess:@escaping(CoachListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
            let bWorkOutResource = BWorkOutResource()
        bWorkOutResource.applyCoachFilterApiCall(request: request) { (response) in
                onSuccess(response)
            } onError: { (error) in
                onError(error)
            }
    }
    
    
    
}
