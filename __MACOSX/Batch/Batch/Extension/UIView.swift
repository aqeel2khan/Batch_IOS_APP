//
//  UIView.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import UIKit
import AVKit

extension UIView{
    
    func createVideoThumbnail(from url: URL) -> UIImage? {
        
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.maximumSize = CGSize(width: frame.width, height: frame.height)
        
        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
        
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func viewCorner(_ radius: CGFloat? = nil) {
        layer.cornerRadius = radius ?? self.frame.height / 2
        layer.masksToBounds = true
    }
    
    func viewBorder(color: UIColor, width: CGFloat = 1.0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func makeRounded() {
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
    func setGradientLinearTopToBottom(colors: [CGColor]){
        
        layer.sublayers = nil
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = [0, 1.0]
        //gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        //gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        //layer.addSublayer(gradientLayer)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBInspectable var cornerRadius:CGFloat{
        set{
            self.layer.cornerRadius = newValue
        }
        get{
            return self.layer.cornerRadius
        }
    }
    
    class func fromNib<T: UIView>() -> T {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! T
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    //MARK:- Rounded specific two corner in uiview
    
    enum RoundedCorner {
        
        case topTwo
        case bottomTwo
        case leftTwo
        case rightTwo
        
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func makeSpecificCornerRound(corners: RoundedCorner,radius: CGFloat){
        switch corners {
        case .bottomTwo:
            
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
            
        case .topTwo:
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            print("")
        case .leftTwo:
            print("")
        case .rightTwo:
            print("")
            
        }
    }
    
}

extension UIView {
    func roundCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}


