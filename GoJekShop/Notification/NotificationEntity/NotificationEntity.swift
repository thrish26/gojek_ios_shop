//
//  NotificationEntity.swift
//  GoJekShop
//
//  Created by anusuya on 18/09/20.
//  Copyright © 2020 appoets. All rights reserved.
//
import UIKit
import ObjectMapper
struct NotificationEntity : Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : NotificationResponseData?
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

struct NotificationResponseData : Mappable {
    var total_records : Int?
    var notification : NotificationPage?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        total_records <- map["total_records"]
        notification <- map["notification"]
    }

}
struct NotificationPage : Mappable {
    var current_page : Int?
    var data : [NotificationData]?
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


struct NotificationData : Mappable {
    var id : Int?
    var notify_type : String?
    var user_id : Int?
    var service : String?
    var title : String?
    var image : String?
    var descriptions : String?
    var expiry_date : String?
    var status : String?
    var is_viewed : Int?
    var company_id : Int?
    var created_type : String?
    var created_by : Int?
    var modified_type : String?
    var modified_by : Int?
    var deleted_type : String?
    var deleted_by : String?
    var created_at : String?
    var updated_at : String?
    var time_at : String?
    var expiry_time : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        notify_type <- map["notify_type"]
        user_id <- map["user_id"]
        service <- map["service"]
        title <- map["title"]
        image <- map["image"]
        descriptions <- map["descriptions"]
        expiry_date <- map["expiry_date"]
        status <- map["status"]
        is_viewed <- map["is_viewed"]
        company_id <- map["company_id"]
        created_type <- map["created_type"]
        created_by <- map["created_by"]
        modified_type <- map["modified_type"]
        modified_by <- map["modified_by"]
        deleted_type <- map["deleted_type"]
        deleted_by <- map["deleted_by"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        time_at <- map["time_at"]
        expiry_time <- map["expiry_time"]
    }

}
