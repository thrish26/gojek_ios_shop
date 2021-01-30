//
//  UpcomingRequestEntity.swift
//  GoJekShop
//
//  Created by Sudar on 16/12/19.
//  Copyright © 2019 appoets. All rights reserved.
//

import Foundation
import ObjectMapper

struct UpcomingRequestEntity : Mappable {
    
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : [UpcomingRequestData]?
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

struct UpcomingRequestData : Mappable {
    var id : Int?
    var admin_service : String?
    var store_order_invoice_id : String?
    var user_id : Int?
    var user_address_id : Int?
    var promocode_id : Int?
    var store_id : Int?
    var store_type_id : Int?
    var provider_id : String?
    var provider_vehicle_id : String?
    var city_id : Int?
    var country_id : Int?
    var note : String?
    var description : String?
    var route_key : String?
    var delivery_date : String?
    var schedule_datetime : String?
    var pickup_address : String?
    var delivery_address : String?
    var order_type : String?
    var order_otp : String?
    var order_ready_time : String?
    var order_ready_status : Int?
    var paid : String?
    var user_rated : Int?
    var provider_rated : Int?
    var cancelled_by : String?
    var cancel_reason : String?
    var currency : String?
    var status : String?
    var schedule_status : Int?
    var assigned_at : String?
    var timezone : String?
    var request_type : String?
    var created_at : String?
    var created_time : String?
    var assigned_time : String?
    var delivery : Delivery?
    var pickup : Pickup?
    var user : UserResponseData?
    var provider : String?
    var invoice : Invoice?
    var store_order_dispute : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        admin_service <- map["admin_service"]
        store_order_invoice_id <- map["store_order_invoice_id"]
        user_id <- map["user_id"]
        user_address_id <- map["user_address_id"]
        promocode_id <- map["promocode_id"]
        store_id <- map["store_id"]
        store_type_id <- map["store_type_id"]
        provider_id <- map["provider_id"]
        provider_vehicle_id <- map["provider_vehicle_id"]
        city_id <- map["city_id"]
        country_id <- map["country_id"]
        note <- map["note"]
        description <- map["description"]
        route_key <- map["route_key"]
        delivery_date <- map["delivery_date"]
        schedule_datetime <- map["schedule_datetime"]
        pickup_address <- map["pickup_address"]
        delivery_address <- map["delivery_address"]
        order_type <- map["order_type"]
        order_otp <- map["order_otp"]
        order_ready_time <- map["order_ready_time"]
        order_ready_status <- map["order_ready_status"]
        paid <- map["paid"]
        user_rated <- map["user_rated"]
        provider_rated <- map["provider_rated"]
        cancelled_by <- map["cancelled_by"]
        cancel_reason <- map["cancel_reason"]
        currency <- map["currency"]
        status <- map["status"]
        schedule_status <- map["schedule_status"]
        assigned_at <- map["assigned_at"]
        timezone <- map["timezone"]
        request_type <- map["request_type"]
        created_at <- map["created_at"]
        created_time <- map["created_time"]
        assigned_time <- map["assigned_time"]
        delivery <- map["delivery"]
        pickup <- map["pickup"]
        user <- map["user"]
        provider <- map["provider"]
        invoice <- map["invoice"]
        store_order_dispute <- map["store_order_dispute"]
    }
    
}


struct Cuisine : Mappable {
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


struct Delivery : Mappable {
    var id : Int?
    var latitude : Double?
    var longitude : Double?
    var map_address : String?
    var flat_no : String?
    var street : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        map_address <- map["map_address"]
        flat_no <- map["flat_no"]
        street <- map["street"]
    }
}

struct Invoice : Mappable {
    var id : Int?
    var store_order_id : Int?
    var payment_mode : String?
    var payment_id : String?
    var store_id : Int?
    var item_price : Double?
    var gross : Int?
    var net : Double?
    var discount : Double?
    var promocode_id : Int?
    var promocode_amount : Double?
    var wallet_amount : Int?
    var tax_per : Int?
    var tax_amount : Double?
    var commision_per : Int?
    var commision_amount : Double?
    var delivery_per : Int?
    var delivery_amount : Double?
    var store_package_amount : Double?
    var total_amount : Double?
    var cash : Int?
    var payable : Int?
    var cart_details : String?
    var status : Int?
    var items : [Items]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_order_id <- map["store_order_id"]
        payment_mode <- map["payment_mode"]
        payment_id <- map["payment_id"]
        store_id <- map["store_id"]
        item_price <- map["item_price"]
        gross <- map["gross"]
        net <- map["net"]
        discount <- map["discount"]
        promocode_id <- map["promocode_id"]
        promocode_amount <- map["promocode_amount"]
        wallet_amount <- map["wallet_amount"]
        tax_per <- map["tax_per"]
        tax_amount <- map["tax_amount"]
        commision_per <- map["commision_per"]
        commision_amount <- map["commision_amount"]
        delivery_per <- map["delivery_per"]
        delivery_amount <- map["delivery_amount"]
        store_package_amount <- map["store_package_amount"]
        total_amount <- map["total_amount"]
        cash <- map["cash"]
        payable <- map["payable"]
        cart_details <- map["cart_details"]
        status <- map["status"]
        items <- map["items"]
    }
}

struct Items : Mappable {
    var id : Int?
    var user_id : Int?
    var store_item_id : Int?
    var store_id : Int?
    var store_order_id : String?
    var quantity : Int?
    var item_price : Int?
    var total_item_price : Double?
    var tot_addon_price : Int?
    var note : String?
    var product_data : String?
    var product : Product?
    var store : Store?
    var cartaddon : [Cartaddon]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        user_id <- map["user_id"]
        store_item_id <- map["store_item_id"]
        store_id <- map["store_id"]
        store_order_id <- map["store_order_id"]
        quantity <- map["quantity"]
        item_price <- map["item_price"]
        total_item_price <- map["total_item_price"]
        tot_addon_price <- map["tot_addon_price"]
        note <- map["note"]
        product_data <- map["product_data"]
        product <- map["product"]
        store <- map["store"]
        cartaddon <- map["cartaddon"]
    }
    
}


struct Itemsaddon : Mappable {
    var id : Int?
    var store_id : Int?
    var store_item_id : Int?
    var store_addon_id : Int?
    var price : Int?
    var addon_name : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_id <- map["store_id"]
        store_item_id <- map["store_item_id"]
        store_addon_id <- map["store_addon_id"]
        price <- map["price"]
        addon_name <- map["addon_name"]
    }
}


struct Pickup : Mappable {
    var id : Int?
    var picture : String?
    var contact_number : String?
    var store_type_id : Int?
    var latitude : Double?
    var longitude : Double?
    var store_location : String?
    var store_name : String?
    var currency_symbol : String?
    var storetype : Storetype?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        picture <- map["picture"]
        contact_number <- map["contact_number"]
        store_type_id <- map["store_type_id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        store_location <- map["store_location"]
        store_name <- map["store_name"]
        currency_symbol <- map["currency_symbol"]
        storetype <- map["storetype"]
    }
    
}

struct Product : Mappable {
    var item_name : String?
    var item_price : Int?
    var id : Int?
    var is_veg : String?
    var picture : String?
    var item_discount : Int?
    var item_discount_type : String?
    var itemsaddon : [Itemsaddon]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        item_name <- map["item_name"]
        item_price <- map["item_price"]
        id <- map["id"]
        is_veg <- map["is_veg"]
        picture <- map["picture"]
        item_discount <- map["item_discount"]
        item_discount_type <- map["item_discount_type"]
        itemsaddon <- map["itemsaddon"]
    }
    
}

struct Store_cusinie : Mappable {
    var id : Int?
    var store_type_id : Int?
    var store_id : Int?
    var cuisines_id : Int?
    var cuisine : Cuisine?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_type_id <- map["store_type_id"]
        store_id <- map["store_id"]
        cuisines_id <- map["cuisines_id"]
        cuisine <- map["cuisine"]
    }
    
}

struct Store : Mappable {
    var store_name : String?
    var currency_symbol : String?
    var picture : String?
    var rating : String?
    var store_packing_charges : Int?
    var store_gst : Int?
    var commission : Int?
    var offer_min_amount : String?
    var offer_percent : Int?
    var free_delivery : Int?
    var id : Int?
    var store_type_id : Int?
    var latitude : Double?
    var longitude : Double?
    var city_id : Int?
    var storetype : Storetype?
    var store_cusinie : [Store_cusinie]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        store_name <- map["store_name"]
        currency_symbol <- map["currency_symbol"]
        picture <- map["picture"]
        rating <- map["rating"]
        store_packing_charges <- map["store_packing_charges"]
        store_gst <- map["store_gst"]
        commission <- map["commission"]
        offer_min_amount <- map["offer_min_amount"]
        offer_percent <- map["offer_percent"]
        free_delivery <- map["free_delivery"]
        id <- map["id"]
        store_type_id <- map["store_type_id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        city_id <- map["city_id"]
        storetype <- map["storetype"]
        store_cusinie <- map["store_cusinie"]
    }
    
}



struct Cartaddon : Mappable {
    var id : Int?
    var store_cart_item_id : Int?
    var store_item_addons_id : Int?
    var store_cart_id : Int?
    var store_addon_id : String?
    var addon_price : Int?
    var addon_name : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        store_cart_item_id <- map["store_cart_item_id"]
        store_item_addons_id <- map["store_item_addons_id"]
        store_cart_id <- map["store_cart_id"]
        store_addon_id <- map["store_addon_id"]
        addon_price <- map["addon_price"]
        addon_name <- map["addon_name"]
    }
    
}
struct Storetype : Mappable {
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

struct UserResponseData : Mappable {
    var id : Int?
    var first_name : String?
    var last_name : String?
    var payment_mode : String?
    var user_type : String?
    var email : String?
    var mobile : String?
    var gender : String?
    var country_code : String?
    var currency_symbol : String?
    var picture : String?
    var login_by : String?
    var latitude : String?
    var longitude : String?
    var wallet_balance : Int?
    var rating : Double?
    var language : String?
    var referral_unique_id : String?
    var country_id : Int?
    var state_id : Int?
    var city_id : Int?
    var company_id : Int?
    var status : Int?
    var created_at : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        payment_mode <- map["payment_mode"]
        user_type <- map["user_type"]
        email <- map["email"]
        mobile <- map["mobile"]
        gender <- map["gender"]
        country_code <- map["country_code"]
        currency_symbol <- map["currency_symbol"]
        picture <- map["picture"]
        login_by <- map["login_by"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        wallet_balance <- map["wallet_balance"]
        rating <- map["rating"]
        language <- map["language"]
        referral_unique_id <- map["referral_unique_id"]
        country_id <- map["country_id"]
        state_id <- map["state_id"]
        city_id <- map["city_id"]
        company_id <- map["company_id"]
        status <- map["status"]
        created_at <- map["created_at"]
    }
    
}
