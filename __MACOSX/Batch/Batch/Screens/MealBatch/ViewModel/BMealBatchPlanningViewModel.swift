//
//  BMealBatchPlanningViewModel.swift
//  Batch
//
//  Created by Krupanshu Sharma on 06/03/24.
//

import Foundation

struct BMealBatchPlanningViewModel{
    func updateBatchMealPlan(urlStr:String, request: UpdateBatchMealPlanRequest, onSuccess:@escaping(UpdateBatchMealPlanResponse) -> Void, onError:@escaping(BatchError) -> Void) {
        let bMealResource = BMealBatchPlanningResource()
        bMealResource.updateBatchMealPlan(urlStr: urlStr, request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
}
