//
//  APIError.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 30.01.2023.
//

import Foundation

enum APIError: Error {
    case parsing(description: String)
    case network(description: String)
    case unknown(description: String)
}
