//
//  OrderStatusMO+CoreDataProperties.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 03.02.2023.
//
//

import Foundation
import CoreData


extension OrderStatusMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderStatusMO> {
        return NSFetchRequest<OrderStatusMO>(entityName: "OrderStatusMO")
    }

    @NSManaged public var status: NSObject

}

extension OrderStatusMO : Identifiable {

}

extension OrderMO {
    var orderStatusType: OrderStatusType? {
        get {
            return OrderStatusType(rawValue: status) ?? nil
        }
        set {
            status = newValue?.rawValue ?? "new"
        }
    }
}
