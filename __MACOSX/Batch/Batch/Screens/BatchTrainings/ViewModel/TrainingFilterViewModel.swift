//
//  TrainingFilterViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct TrainingFilterViewModel {
    
    func allBatchGoal(requestUrl: String, onSuccess:@escaping(AllBatchGoalListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = BWorkOutResource()
        bWOResource.getAllBatchGoal(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    func allWOType(requestUrl: String, onSuccess:@escaping(AllWorkoutTypeListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = BWorkOutResource()
        bWOResource.getAllWOType(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    func allBatchLevel(requestUrl: String, onSuccess:@escaping(AllBatchLevellistResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = BWorkOutResource()
        bWOResource.getAllBatchLevel(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func allCoachFilterList(requestUrl: String, onSuccess:@escaping(AllCoachFilterListtData) -> Void, onError:@escaping(BatchError) -> Void){
        let bWOResource = BWorkOutResource()
        bWOResource.allCoachFilterList(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
