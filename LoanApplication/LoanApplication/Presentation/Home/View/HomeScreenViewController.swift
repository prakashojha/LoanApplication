//
//  HomeScreenViewController.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import UIKit

class HomeScreenViewController: UIViewController {

    let viewModel: HomeScreenViewModel
   
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        setupUI()
        fetchData()
    }
    
    func fetchData() {
        viewModel.fetchData()
    }
    
    func setupUI() {
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: "HomeScreenTableViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        /// Cell separator Insets.
        //tableView.separatorInset = UIEdgeInsets(top: 0, left: Constant.shared.iconImageWidth/8, bottom: 0, right: 0)
        tableView.layoutMargins = .zero
        tableView.accessibilityIdentifier = "HomeScreenTableView"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension HomeScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenTableViewCell", for: indexPath) as? HomeScreenTableViewCell
        let model = viewModel.cellForAtRow(index: indexPath.row)
        cell?.cellViewModel = model
        //cell?.model = summaryItem
        return cell ?? UITableViewCell()
    }
}

extension HomeScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
