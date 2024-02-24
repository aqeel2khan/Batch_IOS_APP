//
//  UITextField.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import UIKit


extension UITextField{
    
    func enableEyeButton(){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        let eyeButton = UIButton(frame: CGRect(x: view.frame.midX - 10, y: view.frame.midY - 10, width: 20, height: 20))
        eyeButton.addTarget(self, action: #selector(onClickEyeButton(sender:)), for: .touchUpInside)
        eyeButton.setImage(#imageLiteral(resourceName: "hidePassword"), for: .normal)
        view.addSubview(eyeButton)
        self.rightViewMode = .always
        self.rightView = view
    
    }
    
    @objc private func onClickEyeButton(sender: UIButton){
        self.isSecureTextEntry = !self.isSecureTextEntry
        if self.isSecureTextEntry{
            sender.setImage(#imageLiteral(resourceName: "hidePassword"), for: .normal)
        }else {
            sender.setImage(#imageLiteral(resourceName: "showPassword"), for: .normal)
        }
    }
    
    
    
}

struct DroverHeight {
    static let haveNotch = CGFloat(320)
    static let dontHaveNotch = CGFloat(320)

}

extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}

@IBDesignable
extension UITextField {
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
}
