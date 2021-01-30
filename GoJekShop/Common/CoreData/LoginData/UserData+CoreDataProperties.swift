//
//  UserData+CoreDataProperties.swift
//  
//
//  Created by Sudar on 12/02/20.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var storeTypeId: Int64

}
