//
//  HURequest.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import Foundation

protocol Request {
    var url: URL { get set }
    var method: HUMethod { get set }
}

struct HURequest: Request {
    var url: URL
    var method: HUMethod
    var requestBody: Data? = nil
}
