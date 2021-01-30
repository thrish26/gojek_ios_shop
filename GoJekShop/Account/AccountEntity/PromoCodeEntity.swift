//
//  PromoCodeEntity.swift
//  GoJekShop
//
//  Created by JeyaPrakash on 06/11/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import Foundation
import ObjectMapper

struct GetPromoCodeEntity : Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : PromoCodeResponseData?
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

struct PromoCodeResponseData : Mappable {
    var current_page : Int?
    var data : [PromoCodeData]?
    var first_page_url : String?
    var from : Int?
    var last_page : Int?
    var last_page_url : String?
    var next_page_url : String?
    var path : String?
    var per_page : Int?
    var prev_page_url : String?
    var to : Int?
    var total : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        current_page <- map["current_page"]
        data <- map["data"]
        first_page_url <- map["first_page_url"]
        from <- map["from"]
        last_page <- map["last_page"]
        last_page_url <- map["last_page_url"]
        next_page_url <- map["next_page_url"]
        path <- map["path"]
        per_page <- map["per_page"]
        prev_page_url <- map["prev_page_url"]
        to <- map["to"]
        total <- map["total"]
    }
}


struct PromoCodeData : Mappable {
    var id : Int?
    var store_id : Int?
    var promo_code : String?
    var promo_description : String?
    var picture : String?
    var store_category_id : Int?
    var percentage : Int?
    var max_amount : Int?
    var min_amount : Int?
    var user_limit : String?
    var expiration : String?
    var service : Int?
    var eligibility : Int?
    var status : Int?
    var startdate : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_id <- map["store_id"]
        promo_code <- map["promo_code"]
        promo_description <- map["promo_description"]
        picture <- map["picture"]
        store_category_id <- map["store_category_id"]
        percentage <- map["percentage"]
        max_amount <- map["max_amount"]
        min_amount <- map["min_amount"]
        user_limit <- map["user_limit"]
        expiration <- map["expiration"]
        status <- map["status"]
        service <- map["service"]
        eligibility <- map["eligibility"]
        startdate <- map["startdate"]
    }
}
