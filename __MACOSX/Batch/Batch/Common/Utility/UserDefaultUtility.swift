//
//  UserDefaultUtility.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import Foundation

struct UserDefaultUtility
{
    static func setUserLoggedIn(_ bool: Bool){
        UserDefaults.standard.set(bool, forKey: "LOGGED_IN")
    }
    
    static func isUserLoggedIn() -> Bool{
        return UserDefaults.standard.bool(forKey: "LOGGED_IN")
    }
    
    func saveCountryName(nameStr: String) {
        UserDefaults.standard.set(nameStr, forKey: USER_DEFAULTS_KEYS.SELECTED_COUNTRY)
    }
    
    
    func getCountryName() -> String {
       return UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.SELECTED_COUNTRY) as? String ?? "Kuwait"
    }
  
    func getUserId() -> Int {
        return UserDefaults.standard.value(forKey: UserDefaultKey.USER_ID) as! Int
    }
    
    static func saveUserId(userId: Int){
        UserDefaults.standard.setValue(userId, forKey: UserDefaultKey.USER_ID)
    }

}
