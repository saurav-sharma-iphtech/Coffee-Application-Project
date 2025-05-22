//
//  OrdersPrice+CoreDataProperties.swift
//  Coffee Application Project
//
//  Created by iPHTech 26 on 22/05/25.
//
//

import Foundation
import CoreData


extension OrdersPrice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrdersPrice> {
        return NSFetchRequest<OrdersPrice>(entityName: "OrdersPrice")
    }

    @NSManaged public var deliveryCharge: String?
    @NSManaged public var totalAmount: String?
    @NSManaged public var subTotal: String?
    @NSManaged public var taxAmount: String?

}

extension OrdersPrice : Identifiable {

}
