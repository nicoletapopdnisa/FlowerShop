//
//  Constants.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import Foundation

// I can make this an open class and subclass it according to the implementation level (data, bl, ui, etc)
public struct Constants {
    
    public static let bundle = Bundle(for: OrdersViewController.self)
    
    // MARK: - Storyboard -
    public struct Storyboard {
        public static let Main = "Main"
    }
    
    // MARK: - ViewController -
    public struct ViewController {
        public static let Orders = "OrdersViewController"
    }
    
    // MARK: - Coordinator -
    public struct Coordinator {
        public static let App = "AppCoordinator"
        public static let Orders = "OrdersCoordinator"
        public static let OrderDetail = "OrderDetailCoordinator"
    }
    
    // MARK: - Layout -
    public struct Layout {
        public static let activityIndicatorViewWidthHeight = 100.0
        public static let headerViewMinHeight = 150.0
        public static let spacerHeight = 20
        public static let padding = 10
    }
    
    // MARK: - UIImage -
    public struct Image {
        public static let cloud = "cloudImage"
    }
    
    // MARK: - Cell -
    public struct Cell {
        public static let Order = "OrderCell"
    }
    
    // MARK: - Location -
    public struct Location {
        public static let distanceFilter = 10.0
    }
    
    public struct Message {
        public static let noDataClientLocation = "No client data and location available."
        public static let noDataClient = "No client data available."
        public static let noDataLocation = "No location available."
        public static let distanceFrom = "Distance from"
    }
    
    public struct View {
        public static let arrowBack = "arrow.backward"
    }
}
