//
//  LoadingIndicatorViewConfigurator.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import UIKit
import NVActivityIndicatorView

protocol LoadingIndicatorViewConfigurator {
    func configure(for activityIndicator: LoadingIndicator)
}
