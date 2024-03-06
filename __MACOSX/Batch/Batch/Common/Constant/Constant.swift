//
//  Constant.swift
//  Batch
//
//  Created by CTS-Jay Gupta on 13/12/23.
//

import Foundation
import UIKit

let Batch_AppDelegate = UIApplication.shared.delegate as! AppDelegate

let Batch_UserDefaults = UserDefaults.standard

// Live Fatoora Payment Token
//let MF_Token = "eQnUzIzBo_fU_5_0OL0zeBxyR89gYfC4_vNFGhkYSEv1XARgliorHHzlYrn8HuEqcNHEpbKzoUdpIJD9U_LKGIE0Q3oyQepvq9RmsflpJv8MhBrFnTcdo9mgbNi3suj4vn-Eqdgyua_J9Qv6Qs2Bk8PmhLJj-zd8zZ5QQKN383VJ21wmEBK8n1TPVAhWzvPmmb37zkZRfdmH26CBK8ti9l-D3RbojlTX6YHEK3pMmLJgAtpY-QCYo8RFcZioAb5Jzhn-8HrLUKdwKHYzN-nPE7Gkd4wdTQFQyHxS4-_XJflJS-6jGGisKDWo4tJkNTN9535S0LRYVMSsHCv-nMtL_SvGQ2JPxTcL-41s5EWZz9XpHM_XKrBysieT5981Fus1QJ5YRHCHh8eXRVoSuinMNNFtm6xJdIZoOXU64acMlHZWTUhJpkWdjHzjCfdB5x-lMaFzAYmpSxROYTih9J1IvYgHCyKjdsGYgcGYdXEGxgoQ4bVBrq5wdmADIBU2UJbAQe_XTac1aVaDDty2aVAwWXQ2PxktoGfPC4u9K2Ekz0O-TNyOwE1BeUNR1GC60prPU5-tXH0eJq-FwYjgFgQYAg1dJ6lgkDyaWKrRLUrrDYuaqfk5HYO5PDYGXF5SM1Ox7EjFAqRT7v5Ip7qOxli5gYIqffq1NiPt-EUx80Qc-IY-TQKe1tpzFLUSv17HkNi85WOLnA"

// Sandbox Fatoora Payment Token
let MF_Token = "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL"




//enum CustomNavTitle : String {
//
//    case batchWorkOutVC = "Workout Batches" // OnBoarding Screens
////    case batchLogInSignUp = "BatchLogInSignUp"
////    case batchTabBar = "BatchTabBar"
////    case batchHome = "BatchHome"
////    case batchTrainings = "BatchTrainings"
////    case batchMealPlans = "BatchMealPlans"
////    case batchShopping = "BatchShopping"
////    case batchBarcodeScanner = "BatchBarcodeScanner"
////    case batchAccount = "BatchAccount"
//}

struct SetConstantTitle
{
    static var segmentFirstTitle = "Batches".localized()
    static var segmentSecondTitle = "Motivators".localized()
    
    static var bWorkOutHeaderLblText = "Workout Batches".localized()
    
    
}
struct CustomNavTitle
{
    static var bWorkOutVCNavTitle = "Workout Batches".localized()
    static var batchBoardHomeVCNavTitle = "Batcheboard".localized()
    static var mealBatchVCNavTitle = "Meal Batch".localized()
    static var qustionVCTitle = "Questionnaire".localized()
    static var dashboardVCNavTitle = "Batchboard".localized()
    
    //    static var questionnaireNavTitle = "Questionnaire".localized()
    
}

struct BatchConstant
{
    static var contentSize = "contentSize"
}

struct API {
    
    // Staging Base URL
    static let baseUrl = "http://admin.batch.com.co/public/api/v1"
    
    static let coachList = baseUrl + "/coach/list"// post
    static let coachDetail = baseUrl + "/coach/detail/"// get
    static let motivatorCourseList = baseUrl + "/course/list"// post
    
    
    static let courseList  = baseUrl + "/course/list"// post
    static let courseDetail    = baseUrl + "/course/detail/" // get
    
    static let allBatchLevelList  = baseUrl + "/course/batchlevels"// get
    static let allWOTypeList    = baseUrl + "/course/workouttypes" // get
    static let allBatchGoalList  = baseUrl + "/course/batchgoals"// get
    static let allCoachFilterList  = baseUrl + "/coach/filter/entity"// get
    
    static let courseWOList  = baseUrl + "/course/workout/list/"// get
    static let courseWODetail    = baseUrl + "/course/workout/detail/56" // get
    
    static let createCourseOrder  = baseUrl + "/course/order/create"// post
    static let addPromoCode  = baseUrl + "/course/promocode/apply"// post
    static let getPromoCodeList  = baseUrl + "/course/promocode/list"// post
    
    static let courseSubscribeList  = baseUrl + "/course/order/list"// post
    
    static let logIn = baseUrl + "/auth/signin"// post
    static let signUp = baseUrl + "/auth/signup"// post
    
    
    static let motivatorFollow = baseUrl + "/coach/follow/"// get
    static let motivatorUnfollow = baseUrl + "/coach/unfollow/"// get
    
    //Meal Module
    static let mealList  = baseUrl + "/meal/list"// post
    static let mealDetail  = baseUrl + "/meal/details/"// get
    static let dishesList  = baseUrl + "/meal/dishes/"// get
    static let dishesDetail  = baseUrl + "/dish/details"// post
    static let filterOption  = baseUrl + "/meal/filters"// post
    static let topRatedMealList  = baseUrl + "/meal/list"// post
    
    // BatchBoard Home Module
    static let createSubscriptionMeal  = baseUrl + "/subscription/subscribe"// post
    
    static let subscriptionMealList = baseUrl + "/subscription/list" // post
    static let subscriptionMealDetail = baseUrl + "/subscription/details" // post"
    static let subscriptionMealUpdate = baseUrl + "subscription/update" // post
    
    //Account Module
    static let getProfileDetail  = baseUrl + "/account/profile"// get
    static let getFollowingDetail  = baseUrl + "/account/following"// get
    static let getNotificationPrefrences  = baseUrl + "/account/notification"// get
    static let updateProfileDetail  = baseUrl + "/account/profile"// post
    static let logout = baseUrl + "/account/logout"// post
}
