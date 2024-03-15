//
//  BatchTextField.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 14/12/23.
//

import UIKit

@IBDesignable
class BatchTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTextField()
    }
    
    override func prepareForInterfaceBuilder() {
        configureTextField()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        placeholder = placeholder?.localized
    }
    
    func configureTextField(){
//        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
//        self.leftView = leftView
//        self.leftViewMode = .always
//        self.tintColor = Colors.appThemeBackgroundColor//Colors.darkGray
//        self.backgroundColor = Colors.appThemeBackgroundColor//Colors.lightGray
//        self.layer.cornerRadius = 15
//        self.layer.borderColor = Colors.appThemeBackgroundColor.cgColor //Colors.borderColor.cgColor
//        self.layer.borderWidth = 0.5
    }
    
    enum Direction {
        case Left
        case Right
    }
    
    func addImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 34))
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 34)
        mainView.addSubview(imageView)
        
        
        if(Direction.Left == direction){
            self.leftViewMode = .always
            self.leftView = mainView
        } else {
            self.rightViewMode = .always
            self.rightView = mainView
        }
        
    }
}
