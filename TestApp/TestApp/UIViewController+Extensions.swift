//
//  UIViewController+Extensions.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 02.02.2023.
//

import UIKit

extension UIViewController {
    func add(loadingIndicator: LoadingIndicator?) {
        if let indicator = loadingIndicator {
            indicator.center = view.center
            view.addSubview(indicator)
        }
    }
}
