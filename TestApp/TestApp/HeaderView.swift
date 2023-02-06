//
//  OrdersHeaderView.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import UIKit

protocol HeaderConfiguration {
    func configure(with viewModel: BaseViewModel?, backgroundColor: UIColor)
}

class HeaderView: XibView {
    
    // MARK: - Properties -
    
    @IBOutlet var title: UILabel!
    @IBOutlet var icon: UIImageView!
    
    // MARK: - View Lifecycle -
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
   
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        frame.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    }
    
    func changeAlpha(_ value: CGFloat) {
        contentView.alpha = value
    }
}

extension HeaderView: HeaderConfiguration {
    func configure(with viewModel: BaseViewModel?, backgroundColor: UIColor) {
        contentView.backgroundColor = backgroundColor
        title.text = viewModel?.title
        guard let iconImage = viewModel?.navIcon else {
            icon.image = UIImage(systemName: Constants.Image.cloud)
            return
        }
        icon.image = UIImage(named: iconImage)
    }
}
