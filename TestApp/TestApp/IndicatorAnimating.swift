//
//  IndicatorAnimating.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 01.02.2023.
//

import Foundation

protocol IndicatorAnimating {
    var loadingAnimator: LoadingAnimator? { get set }
    var type: LoadingIndicatorType? { get set }
}

extension IndicatorAnimating {
    func showLoadingIndicator() {
        loadingAnimator?.addLoadingView()
    }
    
    func hideLoadingIndicator() {
        loadingAnimator?.removeLoadingView()
    }
}
