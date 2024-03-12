//
//  BUserProfileResource.swift
//  Batch
//
//  Created by Vijay Singh on 05/03/24.
//

import Foundation
import UIKit
public struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    init(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = String(Date().timeIntervalSince1970) + ".jpg"
        let data =  image.jpegData(compressionQuality: 0)
        self.data = data ?? Data()
    }
}
struct BUserProfileResource{
    
    func getProfileDetails(onSuccess:@escaping(GetProfileResponse) -> Void, onError:@escaping(BatchError) -> Void){
        let huRequest = HURequest(url: URL(string: API.getProfileDetail)!, method: .get)
        HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: GetProfileResponse.self) { (result) in
            switch result{
            case .success(let response):
                onSuccess(response!)
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func updateProfilePhoto(mediaList: Media,onSuccess:@escaping(GetProfileResponse) -> Void, onError:@escaping(BatchError) -> Void) {
        let urlString = API.updateProfilephoto
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        //create boundary
        let boundary = generateBoundary()
        //set content type
        let appToken = Batch_UserDefaults.value(forKey: UserDefaultKey.TOKEN) as? String ?? ""
        request.timeoutInterval = 60
        request.setValue("Bearer \(appToken)", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(media: mediaList, boundary: boundary)
        request.httpBody = dataBody
        
        performOperation(requestUrl: request) { (result) in
            switch result{
            case .success(let resp):
                onSuccess(resp!)
            case .failure(let err):
                onError(err)
            }
        }
    }
    
    private func createDataBody(media: Media?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        if let medialist = media {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(medialist.key)\"; filename=\"\(medialist.filename)\"\(lineBreak)")
            body.append("Content-Type: \(medialist.mimeType + lineBreak + lineBreak)")
            body.append(medialist.data)
            body.append(lineBreak)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        print(body)
        return body
    }
    private func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func performOperation(requestUrl: URLRequest, completionHandler:@escaping(Result<GetProfileResponse?, HUNetworkError>) -> Void)
    {
        let dataTask = URLSession.shared.dataTask(with: requestUrl) { (data,httpUrlResponse,error) in
            let statusCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode
            if(error == nil && data != nil && data?.count != 0 ){
                let response = HttpUtility.shared.decodeJsonResponse(data: data!, responseType: GetProfileResponse.self)
                if(response != nil){
                    completionHandler(.success(response))
                }else{
                    completionHandler(.failure(HUNetworkError(forRequestUrl: requestUrl.url?.absoluteURL ?? URL(fileURLWithPath: ""), errorMessage: "error in response", forStatusCode: 400)))
                }
            }
            else
            {
                completionHandler(.failure(HUNetworkError(forRequestUrl: requestUrl.url?.absoluteURL ?? URL(fileURLWithPath: ""), errorMessage: "error in response", forStatusCode: 400)))
            }
        }
        dataTask.resume()
    }
}


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
    
    var hexDescription: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
    
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        var i = hexString.startIndex
        for _ in 0..<len {
            let j = hexString.index(i, offsetBy: 2)
            let bytes = hexString[i..<j]
            if var num = UInt8(bytes, radix: 16)
            {      data.append(&num, count: 1)
                
            } else {
                return nil
            }
            i = j
        }
        self = data
    }
}
