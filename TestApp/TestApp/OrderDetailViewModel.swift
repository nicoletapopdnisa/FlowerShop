//
//  OrderDetailViewModel.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import SwiftUI
import Combine
import CoreLocation

class OrderDetailViewModel: ObservableObject {
    @Published var order: Order
    @Published var client: Client? = nil
    let locationManager = LocationManager()
        
    @Published var currentLocation: CLLocation?
    
    private var cancellables = Set<AnyCancellable>()
    private var _loadingClosure: ((Bool) -> Void)?

    init(order: Order) {
        self.order = order
        locationManager.delegate = self
        startUpdatingLocation()
    }
    
    func getClient() {
        onLoadingStateChanged?(true)
        
        let clientsMO = CoreDataManager.shared.read(entityType: ClientMO.self, predicate: NSPredicate(format: "id == %d", order.customerId))
        if let clientMO = clientsMO.first {
            client = Client(from: clientMO)
            onLoadingStateChanged?(false)
            return
        }
            
        getClientFromAPI()
    }
    
    func getClientFromAPI() {
        APIRequest.shared.getClient(customerId: order.customerId)
            .map { response in
                let clientData = response.client
                let client = Client(id: clientData.id, name: clientData.name, latitude: clientData.latitude, longitude: clientData.longitude)
    
                let clientMO = CoreDataManager.shared.create(entityType: ClientMO.self)
                clientMO.setProperties(client: client)
                CoreDataManager.shared.saveContext()
                
                return client
            }.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] received in
                guard let strongSelf = self else { return }
                switch received {
                    case .failure:
                    strongSelf.client = Client(id: 143, name: "Maria", latitude: 45.36783, longitude: 27.34967)
                
                    case .finished:
                        break
                    }
                strongSelf.onLoadingStateChanged?(false)
                
            }, receiveValue: { [weak self] displayedClient in
                guard let strongSelf = self else { return }
                strongSelf.client = displayedClient
            })
            .store(in: &cancellables)
    }
    
    func changeStatus(newValue: String) {
        onLoadingStateChanged?(true)
        APIRequest.shared.changeStatus(orderId: order.id, status: newValue)
            .map{ response in
                let orderData = response.order
                let order = Order(id: orderData.id, desc: orderData.description, price: orderData.price, customerId: orderData.customerId, imageUrl: orderData.imageUrl, status: orderData.status)
                
                if let orderMO = CoreDataManager.shared.read(entityType: OrderMO.self, predicate: NSPredicate(format: "id == %d", order.id)).first {
                    orderMO.setProperties(order: order)
                    CoreDataManager.shared.update(object: orderMO)
                }

                return order
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] received in
                guard let strongSelf = self else { return }
                switch received {
                    case .failure:
                        break
                    
                    case .finished:
                        break
                    }
                            
                strongSelf.onLoadingStateChanged?(false)
                            
            }, receiveValue: { [weak self] (displayedOrder: Order) in
                guard let strongSelf = self else { return }
                strongSelf.order = displayedOrder
            })
            .store(in: &cancellables)
    }
}

extension OrderDetailViewModel: BaseViewModel {
    var title: String {
        "Order \(order.id)"
    }
    
    var navIcon: String? {
        nil
    }
    
    var backIcon: String? {
        Constants.View.arrowBack
    }
    
    var onLoadingStateChanged: ((Bool) -> Void)? {
        get {
            _loadingClosure
        }
        set {
            _loadingClosure = newValue
        }
    }
}

extension OrderDetailViewModel: LocationDelegate {
    func gotCurrent(location: CLLocation?) {
        currentLocation = location
    }
}

private extension OrderDetailViewModel {
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
}
