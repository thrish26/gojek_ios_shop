//
//  CreateProductEntity.swift
//  GoJekShop
//
//  Created by Sudar on 18/03/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import Foundation
import ObjectMapper

struct CreateProductEntity : Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : CreateProductResponseData?
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

struct CreateProductResponseData : Mappable {
    var id : Int?
    var store_id : Int?
    var item_name : String?
    var item_description : String?
    var picture : String?
    var store_category_id : Int?
    var is_veg : String?
    var item_price : Int?
    var item_discount : Int?
    var item_discount_type : String?
    var is_addon : Int?
    var status : Int?
    var itemsaddon : [Itemsaddon]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_id <- map["store_id"]
        item_name <- map["item_name"]
        item_description <- map["item_description"]
        picture <- map["picture"]
        store_category_id <- map["store_category_id"]
        is_veg <- map["is_veg"]
        item_price <- map["item_price"]
        item_discount <- map["item_discount"]
        item_discount_type <- map["item_discount_type"]
        is_addon <- map["is_addon"]
        status <- map["status"]
        itemsaddon <- map["itemsaddon"]
    }
}



struct CreatePromoEntity : Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : PromoCodeData?
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

