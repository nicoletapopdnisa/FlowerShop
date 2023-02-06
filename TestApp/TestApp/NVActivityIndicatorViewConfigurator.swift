//
//  NVLoadingIndicatorView.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import UIKit
import NVActivityIndicatorView

class NVActivityIndicatorViewConfigurator: LoadingIndicatorViewConfigurator {
    func configure(for activityIndicator: LoadingIndicator) {
        if let indicator = activityIndicator as? NVActivityIndicatorView {
            indicator.type = .ballScaleMultiple
            indicator.color = .black
        }
    }
}

extension NVActivityIndicatorView: LoadingIndicator {
    var animating: Bool {
        self.isAnimating
    }
    
    func addLoadingView() {
        self.startAnimating()
    }
    
    func removeLoadingView() {
        self.stopAnimating()
    }
}
