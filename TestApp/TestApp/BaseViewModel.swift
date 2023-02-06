//
//  BaseViewModel.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import UIKit

protocol BaseViewModel {
    var title: String { get }
    var navIcon: String? { get }
    var backIcon: String? { get }
    
    var onLoadingStateChanged: ((Bool) -> Void)? { get set }
}
