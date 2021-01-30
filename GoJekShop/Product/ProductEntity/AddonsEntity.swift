//
//  AddonsEntity.swift
//  GoJekShop
//
//  Created by Sudar on 12/03/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import Foundation
import ObjectMapper

struct AddonsListEntity : Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : [AddonsListResponseData]?
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

struct AddonsListResponseData : Mappable {
    var id : Int?
    var store_id : Int?
    var addon_name : String?
    var addon_status : Int?
    var storeitem : Storeitem?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_id <- map["store_id"]
        addon_name <- map["addon_name"]
        addon_status <- map["addon_status"]
        storeitem <- map["storeitem"]
    }
    
}


struct Storeitem : Mappable {
    var id : Int?
    var store_id : Int?
    var store_item_id : Int?
    var store_addon_id : Int?
    var price : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_id <- map["store_id"]
        store_item_id <- map["store_item_id"]
        store_addon_id <- map["store_addon_id"]
        price <- map["price"]
    }
    
}

struct CreateAddonsEntity : Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : [String]?
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

