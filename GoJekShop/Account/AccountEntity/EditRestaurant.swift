//
//  EditRestaurant.swift
//  GoJekShop
//
//  Created by Sudar on 03/03/20.
//  Copyright © 2020 appoets. All rights reserved.
//

import Foundation
import ObjectMapper

struct EditRestaurantEntity : Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : EditResturantData?
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

struct EditResturantData : Mappable {
    var id : Int?
    var store_type_id : Int?
    var store_name : String?
    var email : String?
    var password : String?
    var store_location : String?
    var street : String?
    var flat_no : String?
    var latitude : Double?
    var longitude : Double?
    var store_zipcode : String?
    var country_id : Int?
    var city_id : Int?
    var zone_id : Int?
    var contact_person : String?
    var contact_number : String?
    var country_code : Int?
    var picture : String?
    var device_token : String?
    var device_id : String?
    var device_type : String?
    var language : String?
    var store_packing_charges : Int?
    var store_gst : Int?
    var commission : Int?
    var is_bankdetail : Int?
    var offer_min_amount : String?
    var offer_percent : Int?
    var estimated_delivery_time : String?
    var rating : Double?
    var otp : String?
    var description : String?
    var status : Int?
    var free_delivery : Int?
    var currency : String?
    var currency_symbol : String?
    var wallet_balance : Int?
    var is_veg : String?
    var cui_selectdata : [Int]?
    var cuisine_data : [Cuisine_data]?
    var store_type : Store_type?
    var time_data : [Time_data]?
    var city_data : [City_data]?
    var zone_data : [Zone_data]?
    var store_response_time : Int?
    var bestseller_month : Int?
    var bestseller : Int?
    var free_delivery_limit : String?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {

        id <- map["id"]
        store_type_id <- map["store_type_id"]
        store_name <- map["store_name"]
        email <- map["email"]
        password <- map["password"]
        store_location <- map["store_location"]
        flat_no <- map["flat_no"]
        street <- map["street"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        store_zipcode <- map["store_zipcode"]
        country_id <- map["country_id"]
        city_id <- map["city_id"]
        zone_id <- map["zone_id"]
        contact_person <- map["contact_person"]
        contact_number <- map["contact_number"]
        country_code <- map["country_code"]
        picture <- map["picture"]
        device_token <- map["device_token"]
        device_id <- map["device_id"]
        device_type <- map["device_type"]
        language <- map["language"]
        store_packing_charges <- map["store_packing_charges"]
        store_gst <- map["store_gst"]
        commission <- map["commission"]
        is_bankdetail <- map["is_bankdetail"]
        offer_min_amount <- map["offer_min_amount"]
        offer_percent <- map["offer_percent"]
        estimated_delivery_time <- map["estimated_delivery_time"]
        rating <- map["rating"]
        otp <- map["otp"]
        description <- map["description"]
        status <- map["status"]
        free_delivery <- map["free_delivery"]
        currency <- map["currency"]
        currency_symbol <- map["currency_symbol"]
        wallet_balance <- map["wallet_balance"]
        is_veg <- map["is_veg"]
        store_response_time <- map["store_response_time"]
        store_type <- map["store_type"]
        cui_selectdata <- map["cui_selectdata"]
        cuisine_data <- map["cuisine_data"]
        time_data <- map["time_data"]
        city_data <- map["city_data"]
        zone_data <- map["zone_data"]
        bestseller_month <- map["bestseller_month"]
        bestseller <- map["bestseller"]
        free_delivery_limit <- map["free_delivery_limit"]
    }

}
    
    struct Store_type : Mappable {
        var id : Int?
        var name : String?
        var category : String?
        var status : Int?

        init?(map: Map) {

        }

        mutating func mapping(map: Map) {

            id <- map["id"]
            name <- map["name"]
            category <- map["category"]
            status <- map["status"]
        }

    }



struct City_data : Mappable {
    var id : Int?
    var company_id : Int?
    var country_id : Int?
    var state_id : Int?
    var city_id : Int?
    var status : Int?
    var city : City?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        company_id <- map["company_id"]
        country_id <- map["country_id"]
        state_id <- map["state_id"]
        city_id <- map["city_id"]
        status <- map["status"]
        city <- map["city"]
    }
    
}

struct City : Mappable {
    var id : Int?
    var country_id : Int?
    var state_id : Int?
    var city_name : String?
    var status : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        country_id <- map["country_id"]
        state_id <- map["state_id"]
        city_name <- map["city_name"]
        status <- map["status"]
    }
    
}

struct Cuisine_data : Mappable {
    var id : Int?
    var store_type_id : Int?
    var name : String?
    var status : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_type_id <- map["store_type_id"]
        name <- map["name"]
        status <- map["status"]
    }
    
}

struct Zone_data : Mappable {
    var id : Int?
    var name : String?
    var city_id : Int?
    var company_id : Int?
    var user_type : String?
    var status : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        city_id <- map["city_id"]
        company_id <- map["company_id"]
        user_type <- map["user_type"]
        status <- map["status"]
    }
    
}
struct Time_data : Mappable {
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

