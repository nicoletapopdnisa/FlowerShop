//
//  OrderMO+CoreDataProperties.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 03.02.2023.
//
//

import Foundation
import CoreData


extension OrderMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderMO> {
        return NSFetchRequest<OrderMO>(entityName: "OrderMO")
    }

    @NSManaged public var id: Int32
    @NSManaged public var desc: String
    @NSManaged public var price: Int32
    @NSManaged public var customerId: Int32
    @NSManaged public var imageUrl: String
    @NSManaged public var status: String
}

extension OrderMO : Identifiable {

}

extension OrderMO {
    static func fromOrder(_ order: Order) -> OrderMO {
        let orderMO = OrderMO(context: CoreDataManager.shared.persistentContainer.viewContext)
        orderMO.id = Int32(order.id)
        orderMO.desc = order.desc
        orderMO.price = Int32(order.price)
        orderMO.customerId = Int32(order.customerId)
        orderMO.imageUrl = order.imageUrl
        orderMO.status = order.status.rawValue
        return orderMO
    }
    
    func setProperties(order: Order) {
        id = Int32(order.id)
        desc = order.desc
        price = Int32(order.price)
        customerId = Int32(order.customerId)
        imageUrl = order.imageUrl
        status = order.status.rawValue
    }
}

extension Order {
    init(from orderMO: OrderMO) {
        self.id = Int(orderMO.id)
        self.desc = orderMO.desc
        self.price = Int(orderMO.price)
        self.customerId = Int(orderMO.customerId)
        self.imageUrl = orderMO.imageUrl
        self.status = OrderStatusType(rawValue: orderMO.status) ?? .new
    }
}
