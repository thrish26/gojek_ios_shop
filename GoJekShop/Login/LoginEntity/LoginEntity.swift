//
//  LoginEntity.swift
//  GoJekProvider
//
//  Created by apple on 28/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import ObjectMapper

//MARK: - LoginEntity

class LoginEntity: Mappable {
    
    var error : Any?
    var message : String?
    var responseData : LoginResponseData?
    var statusCode : String?
    var title : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        error <- map["error"]
        message <- map["message"]
        responseData <- map["responseData"]
        statusCode <- map["statusCode"]
        title <- map["title"]
    }
}

//MARK: - Login Response data

class LoginResponseData: Mappable {
    
    var token_type : String?
    var expires_in : Int?
    var access_token : String?
    var user : User?
    var currency : String?
    var sos : String?
    var contact_number : [Contact_number]?
    var measurement : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        token_type <- map["token_type"]
        expires_in <- map["expires_in"]
        access_token <- map["access_token"]
        user <- map["user"]
        currency <- map["currency"]
        sos <- map["sos"]
        contact_number <- map["contact_number"]
        measurement <- map["measurement"]
    }
}



//MARK: - User Entity

class User: Mappable{
    
    var cityId : Int64?
    var countryId : Int64?
    var createdAt : String?
    var firstName : String?
    var gender : String?
    var id : Int64?
    var store_type_id: Int?
    var store_name: String?
    var email: String?
    var store_location: String?
    var contact_person: String?
    var contact_number: String?
    var country_code: Int64?
    var store_packing_charges: Int?
    var store_gst: Int?
    var commission: Int?
    var is_bankdetail: Bool?
    var offer_min_amount: String?
    var offer_percent: String?
    var estimated_delivery_time: String?
    var lastName : String?
    var latitude : Double?
    var longitude : Double?
    var mobile : String?
    var paymentMode : String?
    var picture : String?
    var rating : Double?
    var stateId : Int64?
    var userType : String?
    var walletBalance : Int?
    var currency_symbol: String?
     var store_type: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        cityId <- map["city_id"]
        countryId <- map["country_id"]
        createdAt <- map["created_at"]
        firstName <- map["first_name"]
        gender <- map["gender"]
        id <- map["id"]
        store_type_id <- map["store_type_id"]
        store_name <- map["store_name"]
        email <- map["email"]
        store_location <- map["store_location"]
        contact_person <- map["contact_person"]
        contact_number <- map["contact_number"]
        country_code <- map["country_code"]
        store_packing_charges <- map["store_packing_charges"]
        store_gst <- map["store_gst"]
        commission <- map["commission"]
        is_bankdetail <- map["is_bankdetail"]
        offer_min_amount <- map["offer_min_amount"]
        offer_percent <- map["offer_percent"]
        estimated_delivery_time <- map["estimated_delivery_time"]
        lastName <- map["last_name"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        mobile <- map["mobile"]
        paymentMode <- map["payment_mode"]
        picture <- map["picture"]
        rating <- map["rating"]
        stateId <- map["state_id"]
        userType <- map["user_type"]
        walletBalance <- map["wallet_balance"]
        currency_symbol <- map["currency_symbol"]
        store_type <- map["store_type"]
    }
}

struct Contact_number : Mappable {
    var number : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        number <- map["number"]
    }
    
}
