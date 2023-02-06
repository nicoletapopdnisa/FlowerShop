//
//  OrdersCoordinator.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import UIKit

protocol OrdersViewControllerDelegate {
    func didSelectDetailFor(_ order: Order)
}

class OrdersCoordinator: BaseCoordinator {
    override func start() {
        let vc = DependencyFactory.configureOrdersScreen()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension OrdersCoordinator: OrdersViewControllerDelegate {
    func didSelectDetailFor(_ order: Order) {
        guard let navController = navigationController else { return }
        let orderDetailCoordinator = OrderDetailCoordinator(identifier: Constants.Coordinator.OrderDetail, navigationController: navController, order: order)
        addChildCoordinator(orderDetailCoordinator)
        orderDetailCoordinator.start()
    }
}
