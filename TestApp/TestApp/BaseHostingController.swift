//
//  BaseHostingController.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 02.02.2023.
//

import SwiftUI

class BaseHostingViewController<VM: BaseViewModel, Content: View>: UIHostingController<Content>, BaseContainer {
    var loadingAnimator: LoadingAnimator?
    var viewModel: VM?
    var type: LoadingIndicatorType? = nil {
        didSet {
            loadingAnimator = configureLoadingAnimator()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        add(loadingIndicator: loadingAnimator?.indicator)
        viewModel?.onLoadingStateChanged = configureLoadingStateObserver()
    }
}
