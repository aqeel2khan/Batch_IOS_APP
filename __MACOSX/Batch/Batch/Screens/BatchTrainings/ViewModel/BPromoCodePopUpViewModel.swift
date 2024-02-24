//
//  BPromoCodePopUpViewModel.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct BPromoCodePopUpViewModel {
    
    func addPromoCodeApi(request: PromoCodeRequest, onSuccess:@escaping(ApplyPromoCodeResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bWOResource = BWorkOutResource()
        
        bWOResource.addPromoCode(request: request) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    func getPromoCodeApi(requestUrl: String, onSuccess:@escaping(GetPromocodeListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let bWOResource = BWorkOutResource()
        bWOResource.getPromoCode(urlStr: requestUrl) { (response) in
            onSuccess(response)
        } onError: { (error) in
            onError(error)
        }
    }
    
    
}
