//
//  OrdersDataSource.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import UIKit

class OrdersDataSource: NSObject {
    var orders: [Order] = []
    
    func configure(cell: OrderCellConfiguration?, at indexPath: IndexPath) {
        cell?.configure(with: orders[indexPath.row])
    }
}

extension OrdersDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.identifier, for: indexPath)
        configure(cell: cell as? OrderCellConfiguration, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
}
