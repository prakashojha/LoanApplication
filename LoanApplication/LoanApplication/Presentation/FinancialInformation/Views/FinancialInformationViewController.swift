//
//  FinancialInformationViewController.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import UIKit

class FinancialInformationViewController: UIViewController, HideKeyboardProtocol, ShowAlertProtocol {
    
    let viewModel: FinancialInformationViewModel

    private lazy var financialInformationView: FinancialInformationView = {
        viewModel.alertMessage = { (message, completion) in
            self.showAlert(message: message, completion: completion)
        }
        return FinancialInformationView(viewModel: viewModel)
    }()
    
    init(viewModel: FinancialInformationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Financial Information"
        addView()
        setConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {
        navigationController?.navigationBar.tintColor = .black

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .systemOrange
        
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
    }
    
    @objc func dismissKeyboardView() {
        view.endEditing(true)
    }
    
    func addView() {
        self.view.addSubview(financialInformationView)
    }
    
    func setConstraints() {
        financialInformationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            financialInformationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            financialInformationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            financialInformationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            financialInformationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
