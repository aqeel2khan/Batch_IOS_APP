//
//  BatchButton.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 14/12/23.
//

import UIKit

@IBDesignable
class BatchButton: UIButton {
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            setUpView()
        }
    }
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            setUpView()
        }
    }
    @IBInspectable var cornerRadiusValue: CGFloat = 20.0 {
        didSet {
            setUpView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadiusValue
        layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
        self.clipsToBounds = true
        self.titleLabel?.font = FontSize.regularSize16
        
        /*
         self.backgroundColor = Colors.appThemeButtonColor
         self.setTitleColor(.white, for: .normal)
         self.layer.cornerRadius = 20
         self.layer.shadowRadius = 5
         self.layer.shadowOffset = .zero
         self.layer.shadowOpacity = 0.3
         */
    }
}


class BatchButtonMedium12White: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }
    
    func setUpView() {
        //self.titleLabel?.text = text?.localized()
        self.titleLabel?.font = FontSize.mediumSize12
        self.titleLabel?.textColor = .white
        
    }
    
}

class BatchButtonMedium14White: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView()
    }
    
    func setUpView() {
        //self.titleLabel?.text = text?.localized()
        self.titleLabel?.font = FontSize.mediumSize14
        self.titleLabel?.textColor = .white
        
    }
    
}
