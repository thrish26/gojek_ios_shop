//
//  BaseEntity.swift
//  GoJekUser
//
//  Created by Sravani on 29/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import ObjectMapper

struct BaseEntity : Mappable {
    var statusCode : String?
    var title : String?
    var message : String?
    var responseData : baseResponseData?
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


struct baseResponseData : Mappable {
    var base_url : String?
    var services : [ServicesList]?
    var appsetting : Appsetting?
    var country : [CountryData]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        base_url <- map["base_url"]
        services <- map["services"]
        appsetting <- map["appsetting"]
        country <- map["country"]
    }
    
}

//Enabled services

struct ServicesList : Mappable {
    var id : Int?
    var admin_service_name : String?
    var base_url : String?
    var status : Int?
    var company_id : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        admin_service_name <- map["admin_service"]
        base_url <- map["base_url"]
        status <- map["status"]
        company_id <- map["company_id"]
    }
    
}


struct Appsetting : Mappable {
    var referral : Int?
    var social_login : Int?
    var otp_verify : Int?
    var ride_otp : Int?
    var order_otp : Int?
    var service_otp : Int?
    var send_sms: Int?
    var send_email: Int?
    var payments : [PaymentDetails]?
    var cmspage : Cmspage?
    var supportdetails : Supportdetails?
    var languages : [Languages]?
    var ios_key: String?
    var country: Int?
    var date_format: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        referral <- map["referral"]
        social_login <- map["social_login"]
        otp_verify <- map["otp_verify"]
        payments <- map["payments"]
        cmspage <- map["cmspage"]
        supportdetails <- map["supportdetails"]
        languages <- map["languages"]
        ios_key <- map["ios_key"]
        ride_otp <- map["ride_otp"]
        order_otp <- map["order_otp"]
        service_otp <- map["service_otp"]
        send_sms <- map["send_sms"]
        send_email <- map["send_email"]
        country <- map["country"]
        date_format <- map["date_format"]
    }
    
}

//Enabled Payment list by admin

struct PaymentList : Mappable {
    var card : String?
    var stripe_secret_key : String?
    var stripe_publishable_key : String?
    var cash : String?
    var stripe_currency : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        card <- map["card"]
        stripe_secret_key <- map["stripe_secret_key"]
        stripe_publishable_key <- map["stripe_publishable_key"]
        cash <- map["cash"]
        stripe_currency <- map["stripe_currency"]
    }
    
}

struct PaymentDetails: Mappable {
    var name: String?
    var status: String?
    var credentials:[PaymentCredentials]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        status <- map["status"]
        credentials <- map["credentials"]
        
    }
}

struct PaymentCredentials:Mappable {
    var name: String?
    var value: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        value <- map["value"]
        
    }
}

struct Cmspage : Mappable {
    var privacypolicy : String?
    var help : String?
    var terms : String?
    var cancel : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        privacypolicy <- map["privacypolicy"]
        help <- map["help"]
        terms <- map["terms"]
        cancel <- map["cancel"]
    }
    
}

struct Supportdetails : Mappable {
    var contact_number : [Contact_number]?
    var contact_email : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        contact_number <- map["contact_number"]
        contact_email <- map["contact_email"]
    }
    
}

struct Languages : Mappable {
    var name : String?
    var key : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        name <- map["name"]
        key <- map["key"]
    }
    
}

struct CountryData: Mappable {
    var id : Int?
    var company_id : Int?
    var country_id : Int?
    var currency : String?
    var currency_code : String?
    var status : Int?
    var country : CountryRespData?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        company_id <- map["company_id"]
        country_id <- map["country_id"]
        currency <- map["currency"]
        currency_code <- map["currency_code"]
        status <- map["status"]
        country <- map["country"]
    }

}
struct CountryRespData: Mappable {
    var id : Int?
    var country_name : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        country_name <- map["country_name"]
    }
}
