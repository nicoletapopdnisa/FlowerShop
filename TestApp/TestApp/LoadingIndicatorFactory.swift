//
//  LoaidngIndicatorFactory.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import UIKit
import NVActivityIndicatorView

class LoadingIndicatorFactory {
    static func createIndicator(type: LoadingIndicatorType, with frame: CGRect) -> LoadingIndicator {
        switch type {
        case .nv:
            return NVActivityIndicatorView(frame: frame)
        }
    }
}
