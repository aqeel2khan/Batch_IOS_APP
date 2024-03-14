//
//  BStartWorkOutDetailViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 14/03/24.
//

import Foundation

struct BStartWorkOutDetailViewModel {
    func startWorkOut(request: StartWorkOutRequset, onSuccess:@escaping(StartWorkOutResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bWorkOutResource = BWorkOutResource()
        bWorkOutResource.startWorkOuts(request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
}
