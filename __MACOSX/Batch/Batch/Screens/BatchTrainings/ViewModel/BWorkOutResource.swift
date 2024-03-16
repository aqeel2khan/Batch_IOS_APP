//
//  BWorkOutResource.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 16/02/24.
//

import Foundation

struct BWorkOutResource {
    
    // BWorkOutVC -->
    
    // Get Course List Api  //1
    func getCourse(urlStr:String, onSuccess:@escaping(CourseResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .postWORequest)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: CourseResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    // Get Coach List Api //2
    func getCoach(urlStr:String, onSuccess:@escaping(CoachListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .postWORequest)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: CoachListResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    // Get Coach List after searching //3
    func getCoachWithSearch(request: SearchRequest, onSuccess:@escaping(CoachListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.coachList)!, method: .post, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: false, resultType: CoachListResponse.self) { (result) in
                switch result{
                    
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
        
    }
    
    // TrainingFilterVC -->
    
    // All Batch Level List
    func getAllBatchLevel(urlStr:String, onSuccess:@escaping(AllBatchLevellistResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let coachDetailContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: coachDetailContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: AllBatchLevellistResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    // All Work Out Type List
    func getAllWOType(urlStr:String, onSuccess:@escaping(AllWorkoutTypeListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let coachDetailContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: coachDetailContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: AllWorkoutTypeListResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    // All Batch Goal List
    func getAllBatchGoal(urlStr:String, onSuccess:@escaping(AllBatchGoalListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let coachDetailContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: coachDetailContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: AllBatchGoalListResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    
    // All CoachFilter List
    func allCoachFilterList(urlStr:String, onSuccess:@escaping(AllCoachFilterListtData) -> Void, onError:@escaping(BatchError) -> Void){
        
        let coachDetailContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: coachDetailContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: AllCoachFilterListtData
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    // BWorkOutMotivatorDetailVC -->
    
    // Coach Detail
    func getCoachDetail(urlStr:String, onSuccess:@escaping(BCoachDetailResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let coachDetailContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: coachDetailContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: BCoachDetailResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    
    // BWorkOutDetailVC -->
    
    // Course Detail
    func getCourseDetail(urlStr:String, onSuccess:@escaping(CourseDetailWSResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let coachDetailContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: coachDetailContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: CourseDetailWSResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    // BPromoCodePopUpVC -->
    
    // Get Promo Code list
    func getPromoCode(urlStr:String, onSuccess:@escaping(GetPromocodeListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let coachDetailContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: coachDetailContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: true, resultType: GetPromocodeListResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    func addPromoCode(request: PromoCodeRequest, onSuccess:@escaping(ApplyPromoCodeResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.addPromoCode)!, method: .post, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: ApplyPromoCodeResponse.self) { (result) in
                switch result{
                    
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
    
    // Get Promo Code list
    func getCoachDetailCourseList(urlStr:String, onSuccess:@escaping(CourseWorkoutListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let coachDetailContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: coachDetailContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: true, resultType: CourseWorkoutListResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    
    // Get Promo Code list
    /*
     func getMotivatorCourseList(urlStr:String, onSuccess:@escaping(motivatorCoachListResponse) -> Void, onError:@escaping(BatchError) -> Void){
     
     let coachDetailContentUrl = URL(string: urlStr)!
     let urlRequest = HURequest(url: coachDetailContentUrl, method: .post)
     
     HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: true, resultType: motivatorCoachListResponse
     .self) { (result) in
     
     switch result{
     case .success(let response):
     onSuccess(response!)
     case .failure(let error):
     onError(error)
     }
     }
     }
     */
    func getMotivatorCourseList(request: motivatorCoachListRequest, onSuccess:@escaping(CourseResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.motivatorCourseList)!, method: .post, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: false, resultType: CourseResponse.self) { (result) in
                switch result{
                    
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
    
    
    
    
    
    
    
    func registrationResourse(request: BRegistrationRequest, onSuccess:@escaping(BRegistrationResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.signUp)!, method: .post, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: false, resultType: BRegistrationResponse.self) { (result) in
                switch result{
                    
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
    
    func applyCourseFilterApiCall(request: CourseFilterRequest, onSuccess:@escaping(CourseResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.courseList)!, method: .post, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: false, resultType: CourseResponse.self) { (result) in
                switch result{
                    
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
    
    func applyCoachFilterApiCall(request: MotivatorFilterRequest, onSuccess:@escaping(CoachListResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.coachList)!, method: .post, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: false, resultType: CoachListResponse.self) { (result) in
                switch result{
                    
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
    
    func createOrderCheckOutApiCall(request: CreateCourseOrderRequest, onSuccess:@escaping(CreateCourseOrderResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.createCourseOrder)!, method: .post, requestBody: requestBody)
            
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: CreateCourseOrderResponse.self) { (result) in
                switch result{
                    
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
    
    func createMealSubscriptionApiCall(request: CreateMealSubscriptionRequest, onSuccess:@escaping(CreateMealSubscriptionResponse) -> Void, onError:@escaping(BatchError) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.createSubscriptionMeal)!, method: .post, requestBody: requestBody)
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: CreateMealSubscriptionResponse.self) { (result) in
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
    
    func createMealSubscriptionApi(request: SubscriptionRequest, onSuccess:@escaping(CreateMealSubscriptionResponse) -> Void, onError:@escaping(BatchError) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.createSubscriptionMeal)!, method: .post, requestBody: requestBody)
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: CreateMealSubscriptionResponse.self) { (result) in
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
    
    // Get Coach Follow UnFollow Api //2
    func followUnfollowApiCall(urlStr:String, onSuccess:@escaping(MotivatorFollowUnFollowResponse) -> Void, onError:@escaping(BatchError) -> Void){
        
        let courseContentUrl = URL(string: urlStr)!
        let urlRequest = HURequest(url: courseContentUrl, method: .get)
        
        HttpUtility.shared.request(huRequest: urlRequest, isAuthorization: false, resultType: MotivatorFollowUnFollowResponse
            .self) { (result) in
                
                switch result{
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
    
    // MARK: - Start WorkOut Resourse
    
    func startWorkOuts(request: StartWorkOutRequset, onSuccess:@escaping(StartWorkOutResponse) -> Void, onError:@escaping(BatchError) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            let huRequest = HURequest(url: URL(string: API.courseStartWorkOut)!, method: .post, requestBody: requestBody)
            HttpUtility.shared.request(huRequest: huRequest, isAuthorization: true, resultType: StartWorkOutResponse.self) { (result) in
                switch result{
                    
                case .success(let response):
                    onSuccess(response!)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error as! BatchError)
        }
    }
}
