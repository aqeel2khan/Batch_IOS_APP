//
//  BCheckoutViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 24/02/24.
//

import Foundation

struct BCheckoutViewModel
{
    func createOrderCheckOut(request: CreateCourseOrderRequest, onSuccess:@escaping(CreateCourseOrderResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bWorkOutResource = BWorkOutResource()
        bWorkOutResource.createOrderCheckOutApiCall(request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
}
