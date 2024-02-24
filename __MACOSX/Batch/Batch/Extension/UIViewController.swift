//
//  UIViewController.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import UIKit
import SVProgressHUD
//import SPAlert
//import SwiftMessages
//import Toast_Swift
//import Malert

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    //    func ShowAlert(message: String, title: String = "Alert") {
    //        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    //        let OKAction = UIAlertAction(title: LTY_AlterText.Ok.localized(), style: .default, handler: nil)
    //        alertController.addAction(OKAction)
    //        self.present(alertController, animated: true, completion: nil)
    //    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - Navigation extension
    func changeVC(item: Int) {
        DispatchQueue.main.async {
            self.tabBarController?.selectedIndex = item
        }
    }
    
    func popToRootVC(animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func popToVC(_ vc: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.popToViewController(vc, animated: true)
        }
    }
    
    func popVC(animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func pushToVC(_ vc: UIViewController, animated: Bool) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func replaceWithVC(_ vc: UIViewController, animated: Bool, number: Int = 1) {
        DispatchQueue.main.async {
            if var viewControllers = self.navigationController?.viewControllers {
                viewControllers.removeLast(number)
                viewControllers.append(vc)
                self.navigationController?.setViewControllers(viewControllers, animated: animated)
            } else {
                self.navigationController?.pushViewController(vc, animated: animated)
            }
        }
    }
    
    func presentVC(_ vc: UIViewController, animated: Bool, presentationStyle: UIModalPresentationStyle) {
        DispatchQueue.main.async {
            vc.modalPresentationStyle = presentationStyle
            self.present(vc, animated: animated, completion: nil)
        }
    }
    
    func dismiss(animated: Bool) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    var activeViewController: UIViewController {
        switch self {
        case let navigationController as UINavigationController:
            return navigationController.topViewController?.activeViewController ?? self
        case let tabBarController as UITabBarController:
            return tabBarController.selectedViewController?.activeViewController ?? self
        case let splitViewController as UISplitViewController:
            return splitViewController.viewControllers.last?.activeViewController ?? self
        default:
            return self
        }
    }
    
    var topMostViewController: UIViewController {
        let activeViewController = self.activeViewController
        return activeViewController.presentedViewController?.topMostViewController ?? activeViewController
    }
    
}

extension UIViewController {
  func showAlert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}


extension UIViewController {
    static var fromStoryboard: Self {
        let selfName = NSStringFromClass(self).components(separatedBy: ".").last!
        let storyboard = UIStoryboard(name: selfName, bundle: nil)
        let customViewController = storyboard.instantiateViewController(withIdentifier: selfName) as! Self
        
        return customViewController
    }
    /*
     func showOkAlert(_ msg: String) {
     let alert = UIAlertController(title:
     "LTY", message: msg, preferredStyle: .alert)
     let okAction = UIAlertAction(title: "OK".localized(), style: .default, handler: nil)
     //        okAction.setValue(AppColor.AppColor2, forKey: "titleTextColor")
     alert.addAction(okAction)
     present(alert, animated: true, completion: nil)
     }
     
     func showOkAlertWithHandler(_ msg: String,handler: @escaping ()->Void){
     let alert = UIAlertController(title: "SUCCESS", message: msg, preferredStyle: .alert)
     let okAction = UIAlertAction(title: "OK".localized(), style: .default) { (type) -> Void in
     handler()
     }
     //        okAction.setValue(AppColor.AppColor2, forKey: "titleTextColor")
     
     alert.addAction(okAction)
     present(alert, animated: true, completion: nil)
     }
     
     func showAlertWithActions( msg: String,titles:[String], handler:@escaping ( _ clickedIndex: Int) -> Void) {
     let alert = UIAlertController(title: "Delete", message: msg, preferredStyle: .alert)
     
     for title in titles {
     let action  = UIAlertAction(title: title, style: .default, handler: { (alertAction) in
     //Call back fall when user clicked
     
     let index = titles.firstIndex(of: alertAction.title!)
     if index != nil {
     handler(index!+1)
     }
     else {
     handler(0)
     }
     })
     //            action.setValue(AppColor.AppColor2, forKey: "titleTextColor")
     
     alert.addAction(action)
     
     }
     present(alert, animated: true, completion: nil)
     }
     
     func showOkCancelAlertWithAction( msg: String, handler:@escaping ( _ isOkAction: Bool) -> Void) {
     let alert = UIAlertController(title: "Craddle", message: msg, preferredStyle: .alert)
     let okAction =  UIAlertAction(title: "OK".localized(), style: .default) { (action) -> Void in
     return handler(true)
     }
     let cancelAction = UIAlertAction(title: "Cancel".localized().localized(), style: .cancel) { (action) -> Void in
     return handler(false)
     }
     //        cancelAction.setValue(AppColor.AppColor2, forKey: "titleTextColor")
     //        okAction.setValue(AppColor.AppColor2, forKey: "titleTextColor")
     
     alert.addAction(cancelAction)
     alert.addAction(okAction)
     present(alert, animated: true, completion: nil)
     }
     
     func topMostController() -> UIViewController? {
     guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
     return nil
     }
     
     var topController = rootViewController
     
     while let newTopController = topController.presentedViewController {
     topController = newTopController
     }
     
     return topController
     }
     
     //MARK:- show Toast
     
     
     
     func showToast(message : String, font: UIFont) {
     
     let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-150, width: 150, height: 35))
     toastLabel.backgroundColor = Asset.Colors.lightGray.color
     toastLabel.textColor = .white
     toastLabel.font = font
     toastLabel.textAlignment = .center;
     toastLabel.text = message
     toastLabel.alpha = 1.0
     toastLabel.layer.cornerRadius = 10;
     toastLabel.clipsToBounds  =  true
     self.view.addSubview(toastLabel)
     UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
     toastLabel.alpha = 0.0
     }, completion: {(isCompleted) in
     toastLabel.removeFromSuperview()
     })
     }
     
     func checkAccess(id:Int,useCaseArr:[RoleDetailList]?) -> (Bool,Bool,Bool){
     var haveReadAccess = false
     var haveWriteAccess = false
     var haveDeleteAccess = false
     for item in useCaseArr ?? [] {
     print(item.useCaseId)
     if item.useCaseId == id {
     for ite in item.permissionIds ?? [] {
     if ite == 1 {
     haveReadAccess = true
     }
     if ite == 2 {
     haveWriteAccess = true
     }
     if ite == 3 {
     haveDeleteAccess = true
     }
     }
     }
     }
     return (haveReadAccess,haveWriteAccess,haveDeleteAccess)
     }
     */
}

// this extension is used for back call on popup using completion

extension UINavigationController {
    func popViewControllerWithHandler(animated:Bool = true, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func pushViewController(viewController: UIViewController, animated:Bool = true,  completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}



//MARK:- Activity indicator view

extension UIViewController {
    func showActivityIndicator() {
//        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))

        activityIndicator.color = Colors.appThemeButtonColor
        
//        activityIndicator.backgroundColor = UIColor.lightGray
//        activityIndicator.alpha = 0.6
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
      //  activityIndicator.style = .UIActivityIndicatorView.Style.large
        activityIndicator.startAnimating()
        
        activityIndicator.tag = 100 // 100 for example

        // before adding it, you need to check if it is already has been added:
        for subview in view.subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }

        view.addSubview(activityIndicator)
    }

    func hideActivityIndicator() {
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()

        // I think you forgot to remove it?
        activityIndicator?.removeFromSuperview()

        //UIApplication.shared.endIgnoringInteractionEvents()
    }
}

// to call this func using completion
/*
 navigationController?.popViewControllerWithHandler(animated: true, completion: {
 print("success")
 })
 
 */








/*
 extension UIViewController{
 func hideKeyboard(){
 DispatchQueue.main.async {
 self.view.endEditing(true)
 }
 }
 
 func hideOfflineMessage(){
 SwiftMessages.hide()
 }
 
 func showOfflineMessage(){
 let view = MessageView.viewFromNib(layout: .statusLine)
 view.configureTheme(.error)
 view.bodyLabel?.text = "OFFLINE"
 
 var config = SwiftMessages.defaultConfig
 config.duration = .forever
 config.dimMode = .gray(interactive: false)
 config.preferredStatusBarStyle = .lightContent
 config.interactiveHide = false
 SwiftMessages.show(config: config, view: view)
 print("Not Connected")
 }
 
 func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
 let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
 let mask = CAShapeLayer()
 mask.path = path.cgPath
 view.layer.mask = mask
 }
 
 func makeToast(_ message: String){
 var style = ToastStyle()
 style.backgroundColor = .black
 style.messageColor = .white
 let windows = UIApplication.shared.windows
 windows.last?.makeToast(message, position: .bottom, style: style)
 
 }
 
 private func createAlertView(title: String?, message: String?) -> Malert{
 
 let customAlertView = HamptonAlertView.instantiateFromNib()
 customAlertView.titleLabel.text = title
 customAlertView.messageLabel.text = message
 customAlertView.messageLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
 
 let alert = Malert(customView: customAlertView)
 alert.buttonsSpace = 15
 alert.buttonsAxis = .horizontal
 alert.textAlign = .center
 alert.buttonsSideMargin = 30
 alert.buttonsBottomMargin = 20
 alert.buttonsHeight = 40
 alert.buttonsSpace = 30
 alert.cornerRadius = 3
 alert.presentDuration = 0.3
 alert.dismissDuration = 0.1
 alert.titleFont = UIFont.systemFont(ofSize: 17)
 alert.animationType = .fadeIn
 return alert
 }
 
 func showTwoButtonAlert(title: String?, message: String?, mainButtonTitle: String, action:@escaping() -> Void){
 
 let alert = createAlertView(title: title, message: message)
 
 let cancelButton = MalertAction(title: "Cancel") {
 self.dismiss(animated: true, completion: nil)
 }
 cancelButton.backgroundColor = Colors.lightGray
 cancelButton.borderWidth = 1
 cancelButton.borderColor = Colors.appThemeColor
 cancelButton.tintColor = Colors.appThemeColor
 cancelButton.cornerRadius = 3
 alert.addAction(cancelButton)
 
 let removeButton = MalertAction(title: mainButtonTitle) {
 action()
 }
 removeButton.backgroundColor = Colors.appThemeColor
 removeButton.tintColor = .white
 removeButton.cornerRadius = 3
 alert.addAction(removeButton)
 
 present(alert, animated: true, completion: nil)
 }
 
 func showOKAlertView(title: String, message: String, okAcion:@escaping() -> Void){
 
 let alert = createAlertView(title: title, message: message)
 
 let removeButton = MalertAction(title: "OK") {
 self.dismiss(animated: true, completion: nil)
 okAcion()
 }
 removeButton.backgroundColor = Colors.appThemeColor
 removeButton.tintColor = .white
 removeButton.cornerRadius = 3
 alert.addAction(removeButton)
 present(alert, animated: true, completion: nil)
 }
 
 func showPopUp(title: String, presentStyle: SPAlertPreset){
 let alertView = SPAlertView(title: "", message: title, preset: presentStyle)
 alertView.duration = 1
 alertView.layout.iconHeight = 40
 alertView.layout.iconWidth = 40
 alertView.layout.bottomIconSpace = 10
 alertView.layout.topSpace = 15
 alertView.layout.bottomSpace = 15
 alertView.present()
 }
 func blurEffect(imageView: UIImageView) {
 let context = CIContext(options: nil)
 let currentFilter = CIFilter(name: "CIGaussianBlur")
 let beginImage = CIImage(image: imageView.image!)
 currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
 currentFilter!.setValue(10, forKey: kCIInputRadiusKey)
 
 let cropFilter = CIFilter(name: "CICrop")
 cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
 cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
 
 let output = cropFilter!.outputImage
 let cgimg = context.createCGImage(output!, from: output!.extent)
 let processedImage = UIImage(cgImage: cgimg!)
 imageView.image = processedImage
 }
 
 func navigateToLoginViewController(){
 UserDefaults.standard.setUserLoggedIn(false)
 UserDefaults.standard.removeObject(forKey: "USER_ID")
 UserDefaults.standard.removeObject(forKey: "EMAIL")
 let loginVC = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
 UIApplication.shared.windows.first?.rootViewController = loginVC
 UIApplication.shared.windows.first?.makeKeyAndVisible()
 //        self.navigationController?.popToViewController(loginVC, animated: true)
 present(loginVC, animated: true, completion: nil)
 }
 
 }
 
 */
