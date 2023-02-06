//
//  OrdersViewController.swift
//  TestApp
//
//  Created by Nicoleta-Denisa Pop on 28.01.2023.
//

import UIKit
import Combine

class OrdersViewController: BaseViewController<OrdersViewModel> {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
   
    // MARK: - Properties -
    
    var tableViewDataSource: OrdersDataSource?
    var tableViewDelegate: OrdersTableDelegate?
    var delegate: OrdersViewControllerDelegate? {
        didSet {
            tableViewDelegate?.coordinator = delegate as? OrdersCoordinator
        }
    }
    
    private var headerView: HeaderView!
    private var headerViewHeightConstraint: NSLayoutConstraint!
    var cancellable: AnyCancellable?
    
    // MARK: - View Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupHeaderView()
        setupTableView()
        cancellable = viewModel?.$orders.sink(receiveValue: { [weak self] orders in
            guard let self = self else { return }
            self.tableViewDataSource?.orders = orders
            self.tableViewDelegate?.orders = orders
            self.tableView.reloadData()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel?.getOrders()
    }
}

// MARK: - Private Methods -

private extension OrdersViewController {
    func setupHeaderView() {
        headerView = HeaderView(frame: CGRect.zero)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerViewHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: Constants.Layout.headerViewMinHeight)
        headerViewHeightConstraint.isActive = true
        
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        headerView.configure(with: viewModel, backgroundColor: .gray)
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: Constants.Cell.Order, bundle: Constants.bundle), forCellReuseIdentifier: Constants.Cell.Order)
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableViewDelegate?.headerView = headerView
        tableViewDelegate?.headerViewHeightConstraint = self.headerViewHeightConstraint
        tableViewTopConstraint.isActive = false
        tableViewTopConstraint = tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0)
        tableViewTopConstraint.isActive = true
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }
}
