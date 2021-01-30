//
//  AppData.swift
//  GoJekUser
//
//  Created by apple on 18/02/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

var deviceTokenString: String = ""

struct AppEnvironment {
    
    static var env = Environment.Dev
}

struct APPConstant {
    static let appName = "Opus X Shop"
    static let salt_key = "MQ=="
    
    static let baseUrl = AppEnvironment.env.baseURL
    static let socketBaseUrl =  AppEnvironment.env.socketBaseUrl
}

enum Environment: String {
    
    case Dev
    case Staging

    var baseURL: String {
        switch self {
        case .Dev:      return "https://api.gox.network/base"
        case .Staging:  return "https://api.gox.network/base"
            //https://api.gox.network/base
        }
    }
    
    var socketBaseUrl: String {
        switch self {
        case .Dev:      return "https://api.gox.network"
        case .Staging:  return "https://api.gox.network"
        }
    }
}

class AppConfigurationManager {
    
    static var shared = AppConfigurationManager()

    var baseConfigModel: BaseEntity!
    var currentService: ServicesList!
    
    func setBasicConfig(data: BaseEntity) {
        self.baseConfigModel = data
    }
    
    func getBaseUrl () -> String {
        if let _ = currentService {
            return currentService.base_url ?? ""
        }else if let _ = baseConfigModel {
           return baseConfigModel.responseData?.base_url ?? ""
        }
        return ""
    }
}
