//
//  OrderCell.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 29.01.2023.
//

import UIKit

protocol OrderCellConfiguration {
    func configure(with order: Order)
}

class OrderCell: UITableViewCell {
    static let identifier = Constants.Cell.Order

    // MARK: - Properties -
    
    @IBOutlet var title: UILabel!
    
    // MARK: - Lifecycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - OrderCellConfiguration -

extension OrderCell: OrderCellConfiguration {
    func configure(with order: Order) {
        title.text = "\(order.id)  \(order.desc)"
    }
}
