//
//  LoginData+CoreDataProperties.swift
//  
//
//  Created by Sudar on 13/02/20.
//
//

import Foundation
import CoreData


extension LoginData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginData> {
        return NSFetchRequest<LoginData>(entityName: "LoginData")
    }

    @NSManaged public var access_token: String?
    @NSManaged public var storeTypeId: Int64
    @NSManaged public var id: Int64
    @NSManaged public var store_name: String?
    @NSManaged public var email: String
    @NSManaged public var store_location: String?
    @NSManaged public var country_id: Int64
    @NSManaged public var city_id: Int64
    @NSManaged public var zone_id: Int64
    @NSManaged public var contact_person: String?
    @NSManaged public var contact_number: String?
    @NSManaged public var country_code: Int64
    @NSManaged public var picture: String?
    @NSManaged public var wallet_balance: Double
    @NSManaged public var currency_symbol: String?
    @NSManaged public var storeMainTypeId: Int64
    @NSManaged public var storeType: String?


}

