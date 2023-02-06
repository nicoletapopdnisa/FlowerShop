//
//  BaseContainer.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 02.02.2023.
//

import UIKit

protocol BaseContainer: IndicatorAnimating {}

extension BaseContainer where Self: UIViewController {
    func configureLoadingAnimator() -> LoadingAnimator? {
        if let indicatorType = type {
            return LoadingAnimator(type: indicatorType, indicatorFrame: CGRect(origin: .zero, size: CGSize(width: Constants.Layout.activityIndicatorViewWidthHeight, height: Constants.Layout.activityIndicatorViewWidthHeight)))
        }
        return nil
    }
        
    func configureLoadingStateObserver() -> ((Bool) -> Void)? {
        return { [weak self] shouldShowIndicator in
            guard let self = self else { return }
            if shouldShowIndicator {
                self.showLoadingIndicator()
            } else {
                self.hideLoadingIndicator()
            }
        }
    }
}
