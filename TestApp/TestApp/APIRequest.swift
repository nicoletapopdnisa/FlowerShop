//
//  APIEndpoints.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 30.01.2023.
//

import Foundation
import Combine

protocol APIEndpointRequestable {
    func getOrders() -> AnyPublisher<OrdersResponse, APIError>
    func getClient(customerId: Int) -> AnyPublisher<ClientResponse, APIError>
    func changeStatus(orderId: Int, status: String) -> AnyPublisher<UpdatedOrderResponse, APIError>
}

class APIRequest {
    private let session: URLSession

    public static let shared = APIRequest()

    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    struct APIURLComponentsFactory {
        static func buildOrdersComponents() -> URLComponents {
            var components = URLComponents()
            components.scheme = MockableAPI.scheme
            components.host = MockableAPI.host
            components.path = MockableAPI.path + "/orders"
            
            return components
        }
        
        static func buildClientComponents(customerId: Int) -> URLComponents {
            var components = URLComponents()
            components.scheme = MockableAPI.scheme
            components.host = MockableAPI.host
            components.path = MockableAPI.path + "/client"
            
            components.queryItems = [
                URLQueryItem(name: "customerId", value: String(customerId)),
            ]
            
            return components
        }
        
        static func buildChangeStatusComponents(orderId: Int, status: String) -> URLComponents {
            var components = URLComponents()
            components.scheme = MockableAPI.scheme
            components.host = MockableAPI.host
            components.path = MockableAPI.path + "/orderStatus"
            
            components.queryItems = [
                URLQueryItem(name: "orderId", value: String(orderId)),
                URLQueryItem(name: "status", value: status)
            ]
            
            return components
        }
    }
}

extension APIRequest: APIEndpointRequestable {
    func getOrders() -> AnyPublisher<OrdersResponse, APIError> {
        return request(with: APIURLComponentsFactory.buildOrdersComponents())
    }
    
    func getClient(customerId: Int) -> AnyPublisher<ClientResponse, APIError> {
        return request(with: APIURLComponentsFactory.buildClientComponents(customerId: customerId))
    }

    func changeStatus(orderId: Int, status: String) -> AnyPublisher<UpdatedOrderResponse, APIError> {
        return request(with: APIURLComponentsFactory.buildChangeStatusComponents(orderId: orderId, status: status), andHttpMethod: "PUT")
    }
}

private extension APIRequest {
    private func request<T>(
      with components: URLComponents
      , andHttpMethod httpMethod: String = "GET") -> AnyPublisher<T, APIError> where T: Decodable {
      guard let url = components.url else {
        let error = APIError.network(description: "Could not create URL")
        return Fail(error: error).eraseToAnyPublisher()
      }
          var req = URLRequest(url: url)
          req.httpMethod = httpMethod
      return session.dataTaskPublisher(for: req)
        .mapError { error in
          .network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) { pair in
            JSONDecoding.decode(pair.data) as AnyPublisher<T, APIError>
        }
        .eraseToAnyPublisher()
    }
}
