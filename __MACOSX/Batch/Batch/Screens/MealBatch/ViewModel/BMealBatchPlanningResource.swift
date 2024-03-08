//
//  BMealBatchPlanningResource.swift
//  Batch
//
//  Created by Krupanshu Sharma on 06/03/24.
//

import Foundation

struct BMealBatchPlanningResource {
    // Meal list API with Post Request. Supports Filter.
    func updateBatchMealPlan(urlStr:String, request: UpdateBatchMealPlanRequest, onSuccess:@escaping(UpdateBatchMealPlanResponse) -> Void, onError:@escaping(BatchError) -> Void) {
        do {
            let requestBody = try JSONEncoder().encode(request)
            do {
                let decodedRequest = try JSONDecoder().decode(UpdateBatchMealPlanRequest.self, from: requestBody)
                print(decodedRequest)
            } catch {
                print("Error decoding request body: \(error)")
            }
            let huRequest = HURequest(url: URL(string: urlStr)!, method: .put, requestBody: requestBody)
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: false, resultType: UpdateBatchMealPlanResponse.self) { (result) in
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
