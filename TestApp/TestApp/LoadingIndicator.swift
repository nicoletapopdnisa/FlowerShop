//
//  LoadingViewInteractor.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import Foundation
import NVActivityIndicatorView

enum LoadingIndicatorType {
    case nv
}

protocol LoadingIndicator where Self: UIView {
    func addLoadingView()
    func removeLoadingView()
    var animating: Bool { get }
}
