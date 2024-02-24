//
//  ShadowView.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import UIKit
@IBDesignable
class ShadowView: UIView {
    
    @IBInspectable
    public var borderWidth: CGFloat = 0.5 {
        didSet{
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    
    @IBInspectable
    var borderColor: UIColor? {
      get {
        if let color = layer.borderColor {
          return UIColor(cgColor: color)
        }
        return nil
      }
      set {
        if let color = newValue {
          layer.borderColor = color.cgColor
        } else {
          layer.borderColor = nil
        }
      }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addShadow()
    }
    
    override func prepareForInterfaceBuilder() {
        addShadow()
    }
    
    func addShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 7
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.1
    }
    
}
