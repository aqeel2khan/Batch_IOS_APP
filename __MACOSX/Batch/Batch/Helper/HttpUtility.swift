//
//  HttpUtility.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import Foundation

public enum HttpError : Error {
    case jsonDecoding
    case noData
    case nonSuccessStatusCode
    case serverError
    case emptyCollection
    case emptyObject
    case invalidURL
    case missingData
}

struct HttpUtility1 {
    
    static let shared = HttpUtility1()
    
    
    //MARK:- POST Api
    
    func coachListWithAsyncURLSession() async throws -> WorkOutMotivatorModel {
        
        
        let url = URL(string:"http://admin.batch.com.co/public/api/v1/coach/list")
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        
        print(data)
        // Parse the JSON data
        let iTunesResult = try JSONDecoder().decode(WorkOutMotivatorModel.self, from: data)
        return iTunesResult
    }
    
    func courseListWithAsyncURLSession() async throws -> CourseModel {
        
        let url = URL(string:"http://admin.batch.com.co/public/api/v1/course/list")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        
        print(data)
        // Parse the JSON data
        let iTunesResult = try JSONDecoder().decode(CourseModel.self, from: data)
        return iTunesResult
    }
    
    
    func getOperation<T:Decodable>(requestUrl: String, response: T.Type) async throws -> T{
            
            guard let url = URL(string:requestUrl) else {
                throw HttpError.invalidURL
            }
            
           // var token = kUserDefaults.value(forKey: AppKeys.token)!
            //let tokenData = "Bearer \(token)"
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
           // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
           // request.addValue(tokenData , forHTTPHeaderField: "Authorization") //
            
            
            do {
                let (serverData, serverUrlResponse) = try await URLSession.shared.data(for:request)
                
                guard let httpStausCode = (serverUrlResponse as? HTTPURLResponse)?.statusCode,
                      (200...599).contains(httpStausCode) else {
                    throw HttpError.nonSuccessStatusCode
                }
                
                return try JSONDecoder().decode(response.self, from: serverData)
            } catch  {
                throw error
            }
        }
    /*
     
     func fetchAlbumWithAsyncURLSession() async throws -> [CountriesList] {
     //        guard let url = URL(string: "https://identity.dev.ltytech.ch/api/ims/v1/config/get/countries") else {
     //            throw AlbumsFetcherError.invalidURL
     //        }
     let url = URL(string:"https://identity.dev.ltytech.ch/api/ims/v1/config/get/countries")
     
     var request = URLRequest(url: url!)
     
     request.httpMethod = "GET"
     
     request.allHTTPHeaderFields = ["Content-Type":"application/json", "User_Agent": "{ \"platform\": \"Android\",\"browser\": \"\",\"browserVersion\": \"\", \"osVersion\": \"13\",\"deviceId\": \"test12\",  \"appVersion\": \"1.0\",\"ipAddress\": \"sdsd\",\"macAddress\": \"\"}"]
     
     // Use the async variant of URLSession to fetch data
     let (data, _) = try await URLSession.shared.data(from: url!)
     
     print(data)
     // Parse the JSON data
     let iTunesResult = try JSONDecoder().decode(CountryModel.self, from: data)
     return iTunesResult.data.countriesList
     }
     
     
     
     /// Make network request using async `URLSession` API
     //  static func fetchAlbumWithAsyncURLSession() async throws -> [DrpDownListStruct] {
     func fetchAlbumWithAsyncURLSession() async throws -> [CountriesList] {
     
     guard let url = URL(string: "https://identity.dev.ltytech.ch/api/ims/v1/config/get/countries") else {
     throw AlbumsFetcherError.invalidURL
     }
     
     // Use the async variant of URLSession to fetch data
     let (data, _) = try await URLSession.shared.data(from: url)
     
     print(data)
     // Parse the JSON data
     let iTunesResult = try JSONDecoder().decode(CountryModel.self, from: data)
     return iTunesResult.data.countriesList
     }
     */
    
}

struct HttpUtility {
    
    static let shared = HttpUtility()
    //public var appToken = "Bearer Bearer 33|eMN7Fd0Z4oBOSC7GjSCxGsYMha54iYtG8YuhL4qfdf5d10e4"
    
    let appToken = Batch_UserDefaults.value(forKey: UserDefaultKey.TOKEN) as! String
    public var apiKey: String = ""
    private init(){}
    
    public func request<T: Decodable>(huRequest: HURequest, isAuthorization:Bool, resultType: T.Type, completion:@escaping(Result<T?, HUNetworkError>) -> Void){
        
        switch huRequest.method {
        case .get:
            getData(requestUrl: huRequest.url, isAuthorization: isAuthorization, responseType: resultType) { completion($0)}
            break
        case .post:
            postData(request: huRequest, isAuthorization: isAuthorization, resultType: resultType) { completion($0)}
            break
        case .postWORequest:
            postDataWithOutRequest(requestUrl: huRequest.url, isAuthorization: isAuthorization, resultType: resultType) { completion($0)}
            break
        case .put:
            break
        case .delete:
            break
        }
    }
    
    private func getData<T:Decodable>(requestUrl: URL, isAuthorization:Bool, responseType: T.Type, completion:@escaping(Result<T?, HUNetworkError>) -> Void){
        
        var urlRequest = createUrlRequest(requestUrl: requestUrl, isAuthorization:isAuthorization)
        urlRequest.httpMethod = HUMethod.get.rawValue
        
        performOperation(urlRequest: urlRequest, responseType: responseType) { (result) in
            completion(result)
        }
    }
    
    private func postData<T: Decodable>(request: HURequest,isAuthorization:Bool, resultType: T.Type, completion:@escaping(Result<T?, HUNetworkError>) -> Void){
        
        var urlRequest = self.createUrlRequest(requestUrl: request.url, isAuthorization:isAuthorization)
        urlRequest.httpMethod = HUMethod.post.rawValue
        urlRequest.httpBody = request.requestBody
        
        performOperation(urlRequest: urlRequest, responseType: T.self) { (result) in
            completion(result)
        }
    }
    
    private func postDataWithOutRequest<T: Decodable>(requestUrl: URL, isAuthorization:Bool, resultType: T.Type, completion:@escaping(Result<T?, HUNetworkError>) -> Void){
        
        var urlRequest = createUrlRequest(requestUrl: requestUrl, isAuthorization:isAuthorization)
        urlRequest.httpMethod = HUMethod.post.rawValue
        
        performOperation(urlRequest: urlRequest, responseType: T.self) { (result) in
            completion(result)
        }
    }
    
    private func performOperation<T: Decodable>(urlRequest: URLRequest, responseType: T.Type, completion:@escaping(Result<T?, HUNetworkError>) -> Void){
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            if error == nil && data != nil && data?.count != 0{
                
                let response = decodeJsonResponse(data: data!, responseType: responseType)
                if response != nil{
                    completion(.success(response))
                }else{
                    completion(.failure(HUNetworkError(withServerResponse: data, forRequestUrl: urlRequest.url!, withHttpBody: urlRequest.httpBody, errorMessage: error.debugDescription, forStatusCode: statusCode!)))
                }
            }else{
                let networkError = HUNetworkError(withServerResponse: data, forRequestUrl: urlRequest.url!, withHttpBody: urlRequest.httpBody, errorMessage: error.debugDescription, forStatusCode: statusCode!)
                completion(.failure(networkError))
            }
        }.resume()
    }
    
    private func createUrlRequest(requestUrl: URL, isAuthorization:Bool) -> URLRequest{
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if isAuthorization {
             let token = "Bearer \(appToken)"
            
            urlRequest.setValue(token, forHTTPHeaderField: "Authorization")
        }
        //urlRequest.setValue(apiKey, forHTTPHeaderField: "XAPIKEY")
        return urlRequest
        
    }
    
    private func decodeJsonResponse<T: Decodable>(data: Data, responseType: T.Type) -> T?{
        
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(responseType, from: data)
        } catch let error {
            debugPrint("deocding error =>\(error.localizedDescription)")
        }
        
        return nil
    }
}
