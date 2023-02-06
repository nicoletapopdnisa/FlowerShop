//
//  OrdersResponse.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 30.01.2023.
//

import Foundation

public struct Item: Codable {
    public var id: Int
    var description: String
    var price: Int
    var customerId: Int
    var imageUrl: String
    var status: OrderStatusType
}

struct OrdersResponse: Codable {
    let orders: [Item]
}
