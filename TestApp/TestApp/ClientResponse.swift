//
//  ClientResponse.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 30.01.2023.
//

import Foundation

struct ClientResponse: Codable {
    let client: ClientData
    
    struct ClientData: Codable {
        var id: Int
        var name: String
        var latitude: Float
        var longitude: Float
    }
}
