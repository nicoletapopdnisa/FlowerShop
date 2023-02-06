//
//  BaseCoordinator.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 27.01.2023.
//

import UIKit

class BaseCoordinator: IdentifiableCoordinator {
    var childCoordinators: [IdentifiableCoordinator] = []
    weak var navigationController: UINavigationController?
    var identifier: String
    
    init(identifier: String, navigationController: UINavigationController) {
        self.identifier = identifier
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController?.pushViewController(DependencyFactory.configureOrdersScreen(), animated: true)
    }
    
    func addChildCoordinator(_ coordinator: IdentifiableCoordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: IdentifiableCoordinator) {
        if let index = childCoordinators.firstIndex(where: { $0.identifier == coordinator.identifier }) {
            childCoordinators.remove(at: index)
        }
    }
}

extension BaseCoordinator: Equatable {
    static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
