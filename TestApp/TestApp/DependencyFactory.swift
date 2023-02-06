//
//  Container.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import UIKit
import SwiftUI

public class DependencyFactory {
    static func configureRootScreen(window: inout UIWindow) {
        let navController = UINavigationController()
        window.rootViewController = navController
        window.makeKeyAndVisible()
        
        let appCoordinator = AppCoordinator(identifier: Constants.Coordinator.App, navigationController: navController)
        appCoordinator.start()
    }
    
    static func configureOrdersScreen() -> OrdersViewController {
        let vc = OrdersViewController.createFromStoryboard()
        vc.type = .nv
        let vm = OrdersViewModel()
        let dataSource = OrdersDataSource()
        let tableDelegate = OrdersTableDelegate()
        vc.tableViewDataSource = dataSource
        vc.tableViewDelegate = tableDelegate
        vc.viewModel = vm
        return vc
    }
    
    static func configureOrderDetailScreen(order: Order) -> OrderDetailViewController {
        
        let vm = OrderDetailViewModel(order: order)
        var view = OrderDetailView(viewModel: vm)
//            .environment(./managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        let vc = OrderDetailViewController(rootView: view)
        vc.type = .nv
        view.delegate = vc.delegate
        vc.viewModel = vm
        return vc
    }
}
