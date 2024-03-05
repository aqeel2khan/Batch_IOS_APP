//
//  BAccountVM.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation


struct BUserFollowingVM{
    
    func getFolowingDetails(onSuccess:@escaping(GetFollowingResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bUserFollwing = BUserFollowingResource()
        bUserFollwing.getFollowingDetails{ response in
            onSuccess(response)
        } onError: { error in
            onError(error)
        }
    }
}
