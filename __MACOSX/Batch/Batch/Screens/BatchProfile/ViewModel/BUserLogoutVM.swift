//
//  BUserLogoutVM.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation


struct BUserLogoutVM{
    
    func logout(onSuccess:@escaping(LogoutResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let bLogout = BUserLogoutResource()
        bLogout.logoutUser{ (response) in
                onSuccess(response)
            } onError: { (error) in
                onError(error)
            }
    }
}
