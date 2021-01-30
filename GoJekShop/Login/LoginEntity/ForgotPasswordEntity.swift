//
//  ForgotPasswordEntity.swift
//  GoJekUser
//
//  Created by  on 29/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import ObjectMapper

class ForgotPasswordEntity: Mappable {
    
    var error : Any?
    var message : String?
    var forgotPasswordData : ForgotPasswordData?
    var statusCode : String?
    var title : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        error <- map["error"]
        message <- map["message"]
        forgotPasswordData <- map["responseData"]
        statusCode <- map["statusCode"]
        title <- map["title"]
    }
}

//MARK: - Login Response data

class ForgotPasswordData: Mappable {
    
    var country_code : String?
    var username : Int?
    var account_type : String?
    var otp : Int?
   
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        country_code <- map["country_code"]
        username <- map["username"]
        account_type <- map["account_type"]
        otp <- map["otp"]
    }
}
