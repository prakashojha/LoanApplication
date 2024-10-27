//
//  ReviewAndSubmitViewController.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import UIKit

class ReviewAndSubmitViewController: UIViewController {

    let viewModel: ReviewAndSubmitViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var editButton: LAUIButton = {
        let button = LAUIButton(configuration: .navigationCustomButton(title: "Edit"))
        button.addTarget(self, action: #selector(onEditButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var submitButton: LAUIButton = {
        let button = LAUIButton(configuration: .navigationCustomButton(title: "Submit"))
        button.addTarget(self, action: #selector(onSubmitButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var navigationButtonView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.addArrangedSubview(editButton)
        view.addArrangedSubview(submitButton)
        view.spacing = 10
        return view
    }()
    
    
    init(viewModel: ReviewAndSubmitViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupUI()
    }
    
    func setupUI() {
        setupTableView()
        setupNavigationButtonView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(ReviewAndSubmitViewCell.self, forCellReuseIdentifier: "ReviewAndSubmitViewCell")
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        /// Cell separator Insets.
        //tableView.separatorInset = UIEdgeInsets(top: 0, left: Constant.shared.iconImageWidth/8, bottom: 0, right: 0)
        tableView.layoutMargins = .zero
        tableView.accessibilityIdentifier = "ReviewAndSubmitView"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupNavigationButtonView() {
        view.addSubview(navigationButtonView)
        navigationButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationButtonView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
            navigationButtonView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            navigationButtonView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
            navigationButtonView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    @objc func onEditButtonPressed() {
        
    }
    
    @objc func onSubmitButtonPressed() {
        
    }
}

extension ReviewAndSubmitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewAndSubmitViewCell", for: indexPath) as? ReviewAndSubmitViewCell
        let summaryItem = viewModel.model[indexPath.row]
        cell?.model = summaryItem
        return cell ?? UITableViewCell()
    }
}

