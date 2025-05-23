//
//  UserDetails+CoreDataProperties.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 23/05/25.
//
//

import Foundation
import CoreData


extension UserDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDetails> {
        return NSFetchRequest<UserDetails>(entityName: "UserDetails")
    }

    @NSManaged public var userName: String?
    @NSManaged public var userGendar: String?
    @NSManaged public var userEmailid: String?
    @NSManaged public var userPhoneNo: String?

}

extension UserDetails : Identifiable {

}
