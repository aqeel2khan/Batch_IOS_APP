//
//  UpdateNotificationResponse.swift
//  Batch
//
//  Created by Vijay Singh on 07/03/24.
//

import Foundation


struct UpdateNotificationRequest: Encodable{
    var all: Int
    var training: Int
    var live_stream: Int
    var meal_plan: Int
    var delivery: Int
    init(all: Int = 0, training: Int = 0, live_stream: Int = 0, meal_plan: Int = 0, delivery: Int = 0) {
        self.all = all
        self.training = training
        self.live_stream = live_stream
        self.meal_plan = meal_plan
        self.delivery = delivery
    }
}

struct UpdateNotificationResponse: Codable{
    
}
