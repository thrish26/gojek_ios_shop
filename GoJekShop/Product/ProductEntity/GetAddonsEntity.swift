//
//  AddonsEntity.swift
//  GoJekShop
//
//  Created by Sudar on 12/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import Foundation
import ObjectMapper

struct AddonsEntity : Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : AddonsResponseData?
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

struct AddonsData : Mappable {
    var id : Int?
    var store_id : Int?
    var addon_name : String?
    var addon_status : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_id <- map["store_id"]
        addon_name <- map["addon_name"]
        addon_status <- map["addon_status"]
    }
    
}

struct AddonsResponseData : Mappable {
    var current_page : Int?
    var data : [AddonsData]?
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
