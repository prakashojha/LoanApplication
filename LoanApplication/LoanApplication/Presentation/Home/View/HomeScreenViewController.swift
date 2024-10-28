//
//  HomeScreenViewController.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import UIKit

class HomeScreenViewController: UIViewController, ShowAlertProtocol {

    let viewModel: HomeScreenViewModel
   
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private lazy var newLoanButtonView: LAUIButton = {
        let button: LAUIButton = LAUIButton(configuration: .newLoanCustomButton)
        button.addTarget(self, action: #selector(onNewLoanButtonPressed), for: .touchUpInside)
        return button
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
        self.view.backgroundColor = UIColor.init(red: 199/255, green: 255/255, blue: 246/255, alpha: 1.0)
        setupUI()
        fetchData()
        self.navigationItem.title = "Loan Details"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "back", style: .done, target: nil, action: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    @objc func onNewLoanButtonPressed(){
        viewModel.applyNewLoan()
    }
    
    func fetchData() {
        viewModel.fetchData(){ [weak self] result in
            switch(result) {
            case .success(_):
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription, completion: nil)
            }
        }
    }
    
    func setupUI() {
        setupTableView()
        setupNewLoanButtonView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(HomeScreenTableViewCell.self, forCellReuseIdentifier: "HomeScreenTableViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layoutMargins = .zero
        tableView.accessibilityIdentifier = "HomeScreenTableView"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -95),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupNewLoanButtonView() {
        view.addSubview(newLoanButtonView)
        newLoanButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newLoanButtonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            newLoanButtonView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            newLoanButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            newLoanButtonView.heightAnchor.constraint(equalToConstant: 44)
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
           
            viewModel.deleteItem(at: indexPath.row){ [weak self] result in
                switch(result) {
                case .success(_):
                    DispatchQueue.main.async {
                        self?.tableView.deleteRows(at: [indexPath], with: .automatic)
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription, completion: nil)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onLoanFileSelected(index: indexPath.row)
    }
}
