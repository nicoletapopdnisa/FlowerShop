//
//  LoadingIndicatorConfiguratorFactory.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import Foundation

class LoadingIndicatorConfiguratorFactory {
    static func create(type: LoadingIndicatorType) -> (any LoadingIndicatorViewConfigurator)? {
        switch type {
        case .nv:
            return NVActivityIndicatorViewConfigurator()
        }
    }
}
