//
//  HomeScreenViewController.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import UIKit

class HomeScreenViewController: UIViewController {

    let viewModel: HomeScreenViewModel
    let coordinator: AppCoordinator?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    init(viewModel: HomeScreenViewModel, coordinator: AppCoordinator?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(ReviewAndSubmitViewCell.self, forCellReuseIdentifier: "HomeScreenTableViewCell")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        /// Cell separator Insets.
        //tableView.separatorInset = UIEdgeInsets(top: 0, left: Constant.shared.iconImageWidth/8, bottom: 0, right: 0)
        tableView.layoutMargins = .zero
        tableView.accessibilityIdentifier = "HomeScreenTableView"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension HomeScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
        //viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenTableViewCell", for: indexPath) as? ReviewAndSubmitViewCell
        //let summaryItem = viewModel.model[indexPath.row]
        //cell?.model = summaryItem
        return cell ?? UITableViewCell()
    }
}
