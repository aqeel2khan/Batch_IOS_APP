//
//  RegistrationError.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import Foundation

protocol BatchError: Error{
    
}

enum RegistrationError: BatchError, LocalizedError {
    case emptyName
    case emptyEmail
    case emptyPhoneNumber
    case emptyAddress
    case emptyPassword
    case emptyConfirmPassword
    
    var errorDescription: String?{
        switch self {
        case .emptyEmail:
            return NSLocalizedString("Enter email address", comment: "")
        case .emptyName:
            return NSLocalizedString("Enter username", comment: "")
        case .emptyPhoneNumber:
            return NSLocalizedString("Enter phone number", comment: "")
        case .emptyAddress:
            return NSLocalizedString("Enter Address", comment: "")
        case .emptyPassword:
            return NSLocalizedString("Enter password", comment: "")
        case .emptyConfirmPassword:
            return NSLocalizedString("Enter confirm password", comment: "")
        }
    }
}
