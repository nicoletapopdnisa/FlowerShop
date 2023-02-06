//
//  OrderDetailViewController.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 31.01.2023.
//

import UIKit
import SwiftUI

class OrderDetailViewController: BaseHostingViewController<OrderDetailViewModel, OrderDetailView> {
    var delegate: OrderDetailCoordinator?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getClient()
    }
}
