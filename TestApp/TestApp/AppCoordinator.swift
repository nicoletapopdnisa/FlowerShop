//
//  AppCoordinator.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 27.01.2023.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    override func start() {
        guard let navController = navigationController else { return }
        let ordersCoordinator = OrdersCoordinator(identifier: Constants.Coordinator.Orders, navigationController: navController)
        childCoordinators.append(ordersCoordinator)
        ordersCoordinator.start()
    }
}
