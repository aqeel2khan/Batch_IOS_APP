//
//  GlobalMethods.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/12/23.
//

import Foundation
import SVProgressHUD

func showLoading(){
    SVProgressHUD.show()
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.setDefaultStyle(.dark)
    SVProgressHUD.setBackgroundColor(.clear)
    SVProgressHUD.setForegroundColor(Colors.appThemeBackgroundColor)
    SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0, vertical: 0))
}

func hideLoading(){
    SVProgressHUD.dismiss()
}

func hideKeyboard(view: UIView){
    view.endEditing(true)
}

