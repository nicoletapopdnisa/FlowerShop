//
//  JSONDecoder.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 30.01.2023.
//

import Foundation
import Combine

struct JSONDecoding {
    static func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        return Just(data)
          .decode(type: T.self, decoder: decoder)
          .mapError { error in
            .parsing(description: error.localizedDescription)
          }
          .eraseToAnyPublisher()
      }

}
