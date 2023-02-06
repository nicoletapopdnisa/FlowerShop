//
//  AbstractViewController.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import UIKit
import SwiftUI
import NVActivityIndicatorView

class BaseViewController<VM: BaseViewModel>: UIViewController, BaseContainer {
    var viewModel: VM?
    var loadingAnimator: LoadingAnimator?
    var type: LoadingIndicatorType? = nil {
        didSet {
            loadingAnimator = configureLoadingAnimator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        add(loadingIndicator: loadingAnimator?.indicator)
        viewModel?.onLoadingStateChanged = configureLoadingStateObserver()
    }
}

extension BaseViewController: StoryboardInstantiating {
    static var storyboardName: String {
        Constants.Storyboard.Main
    }
}
