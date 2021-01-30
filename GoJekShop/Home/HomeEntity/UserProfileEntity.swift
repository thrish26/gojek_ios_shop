//
//  UserProfileEntity.swift
//  GoJekUser
//
//  Created by Rajes on 26/03/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation
import ObjectMapper

class UserProfileResponse:Mappable {
    
    var message : String?
    var responseData : User?
    var statusCode : String?
    var title : String?
    var error : Any?
    
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

