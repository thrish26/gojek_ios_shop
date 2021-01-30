//
//  ShopTimingEntity.swift
//  GoJekShop
//
//  Created by Sudar on 28/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import Foundation
import ObjectMapper

struct EditTimingEntity: Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : [EditTimingResponseData]?
    var error : [String]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        statusCode <- map["statusCode"]
        title <- map["title"]
        message <- map["message"]
        responseData <- map["responseData"]
        error <- map["error"]
    }
    
}


struct EditTimingResponseData : Mappable {
    var id : Int?
    var store_id : Int?
    var store_start_time : String?
    var store_end_time : String?
    var store_day : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_id <- map["store_id"]
        store_start_time <- map["store_start_time"]
        store_end_time <- map["store_end_time"]
        store_day <- map["store_day"]
    }
    
}
