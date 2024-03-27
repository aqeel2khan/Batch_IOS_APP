//
//  UIStoryboard.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import UIKit

enum AppStoryboard : String {
    
    case main = "Main" // OnBoarding Screens
    case batchLogInSignUp = "BatchLogInSignUp"
    case batchTabBar = "BatchTabBar"
    case batchHome = "BatchHome"
    case batchTrainings = "BatchTrainings"
    case batchTrainingsCheckout = "BatchTrainingsCheckout"
    case batchMealPlans = "BatchMealPlans"
    case batchMealPlanQuestionnaire = "BatchMealPlanQuestionnaire"
    case batchShopping = "BatchShopping"
    case batchBarcodeScanner = "BatchBarcodeScanner"
    case batchAccount = "BatchAccount"
    case batchMealPlanCheckout = "BatchMealPlanCheckout"
    case batchDashboard = "BatchDashboard"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
    
}

extension UIStoryboard{
    
    static func mainStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func batchTabBarStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "BatchTabBar", bundle: nil)
    }
    
    static func batchHomeStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "BatchHome", bundle: nil)
    }
    
    static func batchTrainingsStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "BatchTrainings", bundle: nil)
    }
    
    static func batchMealPlansStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "BatchMealPlans", bundle: nil)
    }
    
    static func batchShoppingStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "BatchShopping", bundle: nil)
    }
    
    static func batchBarcodeScannerStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "BatchBarcodeScanner", bundle: nil)
    }
    
    static func batchAccountStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "BatchAccount", bundle: nil)
    }
    
    static func batchMealPlanQuestionnaireStoryboard() -> UIStoryboard{
        return UIStoryboard(name: "BatchMealPlanQuestionnaire", bundle: nil)
    }
}

