//
//  AppDelegate.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignIn
import MFSDK
import Firebase
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.setUpLanguage()
        self.setUpPushNotification()
        
        application.registerForRemoteNotifications()

        //**********Key board manager setup
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarConfiguration.tintColor = Colors.appThemeButtonColor
        
        
        //*******Google Sign In Token
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
        
        //*********** set up your My Fatoorah Merchant details
        MFSettings.shared.configure(token: MF_Token, country: .kuwait, environment: .test)
        // you can change color and title of nvgigation bar
        let them = MFTheme(navigationTintColor: .white, navigationBarTintColor: .lightGray, navigationTitle: "Payment", cancelButtonTitle: "Cancel")
        MFSettings.shared.setTheme(theme: them)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool
        
        //  handled = GIDSignIn.sharedInstance.handle(url)
        handled = GIDSignIn.sharedInstance.handle(URL(string: GOOGLE_CLIENT_ID)!)
        if handled {
            return true
        }
        
        return false
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func setUpLanguage() {
        // check selected language is english or arabic
        if let languageCode = UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE) as? String {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: languageCode)
            UserDefaults.standard.setValue(languageCode, forKey: USER_DEFAULTS_KEYS.APP_LANGUAGE_CODE)

            UIView.appearance().semanticContentAttribute = (languageCode == ENGLISH_LANGUAGE_CODE ? .forceLeftToRight : .forceRightToLeft)
        }
    }
    
    func setUpPushNotification() {
        FirebaseApp.configure()
       
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
    }
}


extension AppDelegate : UNUserNotificationCenterDelegate, MessagingDelegate {
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        // Print full message.
        print(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([.list, .badge, .sound])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo["gcm.message_id"] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler()
    }
    
    internal func messaging(_ messaging: Messaging, didReceiveRegistrationToken
        fcmToken: String?) {
        print("Firebase registration token: \(fcmToken!)")
               UserDefaults.standard.setValue(fcmToken, forKey: USER_DEFAULTS_KEYS.FCM_KEY)
        
        if UserDefaultUtility.isUserLoggedIn() {
            self.updateFCMAPI()
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    // [END ios_10_data_message]o
     
    func updateFCMAPI() {
        let device_token = UserDefaults.standard.value(forKey: USER_DEFAULTS_KEYS.FCM_KEY) as? String ?? ""
        let request = BatchFCMRequest(deviceToken: device_token)
        
        DispatchQueue.main.async {
            showLoading()
        }
        
        let bLogInViewModel = BLogInViewModel()
        bLogInViewModel.fcmApi(request: request) { (response) in
            if response.status == true {
                DispatchQueue.main.async {
                    hideLoading()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
            }
        }        
    }
}
