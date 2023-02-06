//
//  StoryboardInstantiating.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import UIKit

public protocol StoryboardInstantiating: AnyObject {
    static var storyboardName: String { get }
    static var identifier: String { get }
    static var bundle: Bundle { get }
    
    static func createFromStoryboard(bundle: Bundle) -> Self
}

public extension StoryboardInstantiating where Self: UIViewController{
    static var identifier: String {
        return String(describing: self)
    }
    
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    
    static func createFromStoryboard(bundle: Bundle = Bundle(for: Self.self)) -> Self {
        return UIStoryboard.createViewController(in: storyboardName, identifier: identifier, bundle: bundle)
    }
}

public extension UIStoryboard {
    static func createViewController<T: UIViewController>(in storyboard: String, identifier: String = String(describing: T.self), bundle: Bundle = Bundle(for: T.self)) -> T {
        let storyboard = UIStoryboard(name: storyboard, bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Could not create viewcontroller with identifier \(identifier) from storyboard \(storyboard)")
        }
        return viewController
    }
}
