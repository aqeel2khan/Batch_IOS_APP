//
//  UserDefaultUtility.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import Foundation

struct UserDefaultUtility
{
    func saveUserId(userId: Int)
    {
        UserDefaults.standard.set(userId, forKey: "userId")
    }
//    static func saveToken(token: String)
//    {
//        UserDefaults.standard.set(token, forKey: "token")
//    }
//    static func getToken() -> String?{
//        UserDefaults.standard.string(forKey: "token")
//    }
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
        return UserDefaults.standard.value(forKey: "userId") as! Int
    }
    
    static func saveUserId(userId: Int){
        UserDefaults.standard.setValue(userId, forKey: UserDefaultKey.USER_ID)
    }

    /*
     
     static func setUserLoggedIn(_ bool : Bool){
     UserDefaults.standard.setValue(bool, forKey: UserDefaultKey.IS_USER_LOGGED_IN)
     }
     
     static func isUserLoggedIn() -> Bool{
     return UserDefaults.standard.bool(forKey: UserDefaultKey.IS_USER_LOGGED_IN)
     }
     
     
     static func deleteUserId(){
     UserDefaults.standard.removeObject(forKey: UserDefaultKey.USER_ID)
     }
     
     static func deleteToken(){
     UserDefaults.standard.removeObject(forKey: UserDefaultKey.TOKEN)
     }
     
     static func getUserId() -> Int{
     return UserDefaults.standard.integer(forKey: UserDefaultKey.USER_ID)
     }
     
     static func saveToken(token: String){
     UserDefaults.standard.setValue(token, forKey: UserDefaultKey.TOKEN)
     }
     
     static func getToken() -> String?{
     UserDefaults.standard.string(forKey: UserDefaultKey.TOKEN)
     }
     */
}
