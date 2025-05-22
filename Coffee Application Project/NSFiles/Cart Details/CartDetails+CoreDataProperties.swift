//
//  CartDetails+CoreDataProperties.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 19/05/25.
//
//

import Foundation
import CoreData


extension CartDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartDetails> {
        return NSFetchRequest<CartDetails>(entityName: "CartDetails")
    }

    @NSManaged public var itemCount: String?
    @NSManaged public var coffeeName: String?
    @NSManaged public var cupSize: String?
    @NSManaged public var amount: String?
    @NSManaged public var realPrice: String?

}

extension CartDetails : Identifiable {

}
