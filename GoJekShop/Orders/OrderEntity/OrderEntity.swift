//
//  OrderEntity.swift
//  GoJekShop
//
//  Created by Sudar on 24/12/19.
//  Copyright © 2019 appoets. All rights reserved.
//

import Foundation
import ObjectMapper


struct HistoryEntity : Mappable {
   var statusCode : String?
    var title : String?
    var message : String?
    var historyResponseData : HistoryResponseData?
    var error : [String]?
    
    

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        statusCode <- map["statusCode"]
        title <- map["title"]
        message <- map["message"]
        historyResponseData <- map["responseData"]
        error <- map["error"]
    }

}

struct HistoryResponseData : Mappable {
    var current_page : Int?
    var data : [Historydata]?
    var first_page_url : String?
    var from : Int?
    var last_page : Int?
    var last_page_url : String?
    var next_page_url : String?
    var path : String?
    var per_page : String?
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


struct Historydata : Mappable {
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
    var paid : Int?
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
    var total_amount : String?
    var discount : String?
    var payment_mode : String?
    var created_time : String?
    var assigned_time : String?
    var delivery : HistoryDelivery?
    var pickup : HistoryPickup?
    var user : HistoryUser?
    var provider : Provider?
    var order_invoice : Order_invoice?


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
        total_amount <- map["total_amount"]
        discount <- map["discount"]
        payment_mode <- map["payment_mode"]
        created_time <- map["created_time"]
        assigned_time <- map["assigned_time"]
        delivery <- map["delivery"]
        pickup <- map["pickup"]
        user <- map["user"]
        provider <- map["provider"]
        order_invoice <- map["order_invoice"]

    }

}

struct HistoryStoretype : Mappable {
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

struct HistoryUser : Mappable {
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
    var rating : Int?
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



struct HistoryDelivery : Mappable {
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

struct HistoryPickup : Mappable {
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

struct Order_invoice : Mappable {
    var id : Int?
    var store_order_id : Int?
    var payment_mode : String?
    var payment_id : String?
    var store_id : Int?
    var item_price : Int?
    var gross : Double?
    var net : Double?
    var discount : Int?
    var promocode_id : Int?
    var promocode_amount : Int?
    var wallet_amount : Int?
    var tax_per : Int?
    var tax_amount : Double?
    var commision_per : Int?
    var commision_amount : Double?
    var delivery_per : Int?
    var delivery_amount : Int?
    var store_package_amount : Int?
    var total_amount : Int?
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


struct Provider : Mappable {
    var id : Int?
    var first_name : String?
    var last_name : String?
    var payment_mode : String?
    var email : String?
    var country_code : String?
    var currency : String?
    var currency_symbol : String?
    var mobile : String?
    var gender : String?
    var device_token : String?
    var device_id : String?
    var device_type : String?
    var login_by : String?
    var social_unique_id : String?
    var latitude : Double?
    var longitude : Double?
    var current_location : String?
    var stripe_cust_id : String?
    var wallet_balance : Double?
    var is_online : Int?
    var is_assigned : Int?
    var rating : Double?
    var status : String?
    var is_service : Int?
    var is_document : Int?
    var is_bankdetail : Int?
    var admin_id : String?
    var payment_gateway_id : String?
    var otp : String?
    var language : String?
    var picture : String?
    var qrcode_url : String?
    var referral_unique_id : String?
    var referal_count : Int?
    var country_id : Int?
    var state_id : String?
    var city_id : Int?
    var zone_id : Int?
    var activation_status : Int?
    var current_ride_vehicle : String?
    var current_store : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        payment_mode <- map["payment_mode"]
        email <- map["email"]
        country_code <- map["country_code"]
        currency <- map["currency"]
        currency_symbol <- map["currency_symbol"]
        mobile <- map["mobile"]
        gender <- map["gender"]
        device_token <- map["device_token"]
        device_id <- map["device_id"]
        device_type <- map["device_type"]
        login_by <- map["login_by"]
        social_unique_id <- map["social_unique_id"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        current_location <- map["current_location"]
        stripe_cust_id <- map["stripe_cust_id"]
        wallet_balance <- map["wallet_balance"]
        is_online <- map["is_online"]
        is_assigned <- map["is_assigned"]
        rating <- map["rating"]
        status <- map["status"]
        is_service <- map["is_service"]
        is_document <- map["is_document"]
        is_bankdetail <- map["is_bankdetail"]
        admin_id <- map["admin_id"]
        payment_gateway_id <- map["payment_gateway_id"]
        otp <- map["otp"]
        language <- map["language"]
        picture <- map["picture"]
        qrcode_url <- map["qrcode_url"]
        referral_unique_id <- map["referral_unique_id"]
        referal_count <- map["referal_count"]
        country_id <- map["country_id"]
        state_id <- map["state_id"]
        city_id <- map["city_id"]
        zone_id <- map["zone_id"]
        activation_status <- map["activation_status"]
        current_ride_vehicle <- map["current_ride_vehicle"]
        current_store <- map["current_store"]
    }

}
