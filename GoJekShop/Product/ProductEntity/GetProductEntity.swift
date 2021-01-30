//
//  ProductEntity.swift
//  GoJekShop
//
//  Created by Sudar on 12/02/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import Foundation
import ObjectMapper

struct GetProductEntity : Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : ProductResponseData?
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

struct ProductResponseData : Mappable {
    var current_page : Int?
    var data : [ProductData]?
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

struct ProductData : Mappable {
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
    var unit_id : Int?
    var quantity : Int?
    var status : Int?
    var lowStock : Int?
    
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
        unit_id <- map["unit_id"]
        quantity <- map["quantity"]
        lowStock <- map["low_stock"]
    }
}
