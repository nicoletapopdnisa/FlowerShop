//
//  OrderDetailCoordinator.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import UIKit
import SwiftUI

protocol OrderDetailViewControllerDelegate {
    func goBack()
}

class OrderDetailCoordinator: BaseCoordinator {
    let order: Order
    
    init(identifier: String, navigationController: UINavigationController, order: Order) {
        self.order = order
        super.init(identifier: identifier, navigationController: navigationController)
    }
    
    override func start() {
        let vc = DependencyFactory.configureOrderDetailScreen(order: order)
        vc.delegate = self
        vc.rootView.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension OrderDetailCoordinator: OrderDetailViewControllerDelegate {
    func goBack() {
        navigationController?.popViewController(animated: true)
        removeChildCoordinator(self)
    }
}
