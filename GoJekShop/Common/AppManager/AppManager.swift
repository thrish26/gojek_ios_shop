//
//  AppManager.swift
//  GoJekUser
//
//  Created by Ansar on 01/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import Foundation

class AppManager {
    
    static var shared = AppManager()

    public var accessToken: String?
    public var storeId: Int64?
    public var storeType: String?
    public var storeTypeid: Int64?
    public var currency_symbol: String?
   
}


