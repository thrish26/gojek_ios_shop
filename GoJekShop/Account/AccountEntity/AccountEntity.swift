//
//  AccountEntity.swift
//  GoJekUser
//
//  Created by apple on 20/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import ObjectMapper


class CardEntityResponse: Mappable {
    
    var statusCode: String?
    var title: String?
    var message: String?
    var responseData: [CardResponseData]?
    var error: Any?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        statusCode <- map["statusCode"]
        title <- map["title"]
        message <- map["message"]
        responseData <- map["responseData"]
        error <- map["error"]
    }
}

class CardResponseData: Mappable {
    
    var id : Int?
    var user_id : Int?
    var company_id : Int?
    var last_four : String?
    var card_id : String?
    var brand : String?
    var is_default : Int?
    var holder_name : String?
    var month : String?
    var year : String?
    var funding : String?
    var wallet_balance: Double?
    var message: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        user_id <- map["user_id"]
        company_id <- map["company_id"]
        last_four <- map["last_four"]
        card_id <- map["card_id"]
        brand <- map["brand"]
        is_default <- map["is_default"]
        holder_name <- map["holder_name"]
        month <- map["month"]
        year <- map["year"]
        funding <- map["funding"]
        wallet_balance <- map["wallet_balance"]
        message <- map["message"]
    }
    
}


