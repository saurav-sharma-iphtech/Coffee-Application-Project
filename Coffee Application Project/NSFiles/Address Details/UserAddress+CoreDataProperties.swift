//
//  UserAddress+CoreDataProperties.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 21/05/25.
//
//

import Foundation
import CoreData


extension UserAddress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAddress> {
        return NSFetchRequest<UserAddress>(entityName: "UserAddress")
    }

    @NSManaged public var country: String?
    @NSManaged public var state: String?
    @NSManaged public var city: String?
    @NSManaged public var pincode: String?
    @NSManaged public var landmark: String?
    @NSManaged public var area: String?
    @NSManaged public var houseno: String?
    @NSManaged public var fullname: String?
    @NSManaged public var mobno: String?

}

extension UserAddress : Identifiable {

}
