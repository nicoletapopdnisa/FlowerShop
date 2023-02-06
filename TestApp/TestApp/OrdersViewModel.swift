//
//  OrdersViewModel.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import Foundation
import Combine

class OrdersViewModel: ObservableObject {
    @Published var orders: [Order] = []
    
    private var cancellables = Set<AnyCancellable>()
    private var _isLoadingClosure: ((Bool) -> Void)?
    
    func getOrders() {
        self.orders.removeAll(keepingCapacity: true)
        onLoadingStateChanged?(true)
        
        let ordersMO = CoreDataManager.shared.read(entityType: OrderMO.self)
        if !ordersMO.isEmpty {
            ordersMO.forEach { orderMO in
                orders.append(Order(from: orderMO))
            }
            onLoadingStateChanged?(false)
            return
        }
            
        getOrdersFromAPI()
    }
    
    func getOrdersFromAPI() {
        APIRequest.shared.getOrders()
            .map { response in
                response.orders.map{ item in
                    Order(id: item.id, desc: item.description, price: item.price, customerId: item.customerId, imageUrl: item.imageUrl, status: item.status)
                }
            }.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] received in
                guard let strongSelf = self else { return }
                switch received {
                    case .failure:
                        strongSelf.orders = []
                    case .finished:
                        break
                    }
                strongSelf.onLoadingStateChanged?(false)
                
            }, receiveValue: { [weak self] orderList in
                 guard let strongSelf = self else { return }
                strongSelf.orders = orderList
                for order in orderList {
                    let orderMO = CoreDataManager.shared.create(entityType: OrderMO.self)
                    orderMO.setProperties(order: order)
                    CoreDataManager.shared.saveContext()    
                }
                
            })
            .store(in: &cancellables)
    }
}

extension OrdersViewModel: BaseViewModel {
    var title: String {
        "Welcome to my Flower Shop!"
    }
    
    var navIcon: String? {
        "flower"
    }
    
    var backIcon: String? {
        nil
    }

    var onLoadingStateChanged: ((Bool) -> Void)? {
        get {
            _isLoadingClosure
        }
        set {
            _isLoadingClosure = newValue
        }
    }
}
