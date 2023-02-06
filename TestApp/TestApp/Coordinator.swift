//
//  Coordinator.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 27.01.2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func start()
}

protocol IdentifiableCoordinator: Coordinator {
    var identifier: String { get }
}
