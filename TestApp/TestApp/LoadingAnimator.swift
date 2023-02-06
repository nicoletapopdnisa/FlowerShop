//
//  LoadingAnimator.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import Foundation

class LoadingAnimator {
    private let activityIndicator: LoadingIndicator
    private let configurator: LoadingIndicatorViewConfigurator?
    
    var indicator: LoadingIndicator {
        activityIndicator
    }

    init(type: LoadingIndicatorType, indicatorFrame: CGRect) {
        activityIndicator = LoadingIndicatorFactory.createIndicator(type: type, with: indicatorFrame)
        configurator = LoadingIndicatorConfiguratorFactory.create(type: type)
        configurator?.configure(for: activityIndicator)
    }

    func addLoadingView() {
        activityIndicator.addLoadingView()
    }
    func removeLoadingView() {
        activityIndicator.removeLoadingView()
    }
}
