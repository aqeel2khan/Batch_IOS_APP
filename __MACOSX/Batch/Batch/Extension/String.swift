//
//  String.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import UIKit


extension String{
    
    func isValidEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPhone() -> Bool
    {
        let mobileRegEx = NSString(format:"[0-9]{%d}",10) as String
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", mobileRegEx)
        return phoneTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool{
        if self.count >= 6 {
            return true
        }else{
            return false
        }
    }
    
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let paragraphStyle = NSMutableParagraphStyle()
                        paragraphStyle.alignment = .left
            let content = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            
            content.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                   NSAttributedString.Key.foregroundColor: UIColor.white],
                                  range: NSMakeRange(0, content.length))
            
            return content
            
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "\(self)", comment: "")
    }
    
    
}

extension String{
    
    static func flag(for code : String) -> String?{
        func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
            
            return scalar.value >= 0x61 && scalar.value <= 0x7A
        }
        func regionalIndicatorSymbol(for scalar :Unicode.Scalar) -> Unicode.Scalar {
            
            precondition(isLowercaseASCIIScalar(scalar))
            return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
        }
        let lowercasedCode = code.lowercased()
        guard lowercasedCode.count == 2 else { return nil }
        guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in
            accum && isLowercaseASCIIScalar(scalar)
        }) else { return nil }
        let incatorSymbols = lowercasedCode.unicodeScalars.map({regionalIndicatorSymbol(for: $0)})
        
        return String(incatorSymbols.map({Character($0)}))
    }
    
    func removeDecimalValue() -> String {
        return self.components(separatedBy: ".").first ?? "0"
    }
}

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
