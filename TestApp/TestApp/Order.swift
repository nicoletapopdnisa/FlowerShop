//
//  Order.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import Foundation

public enum OrderStatusType: String, Equatable, CaseIterable, Codable, Identifiable {
    public var id: String {self.rawValue}
    case new
    case pending
    case delivered
    
    var uppercaseLabel: String { rawValue.uppercased() }
    
    private enum CodingKeys: String, CodingKey {
        case new = "new"
        case pending = "pending"
        case delivered = "delivered"
    }
}

public struct Order: Codable, Identifiable {
    public var id: Int
    var desc: String
    var price: Int
    var customerId: Int
    var imageUrl: String
    var status: OrderStatusType
    
    enum CodingKeys: String, CodingKey {
        case id
        case desc
        case price
        case customerId
        case imageUrl
        case status
    }
}
