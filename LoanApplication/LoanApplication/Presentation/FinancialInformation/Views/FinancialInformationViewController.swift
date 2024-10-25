//
//  FinancialInformationViewController.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import UIKit

class FinancialInformationViewController: UIViewController, HideKeyboardProtocol {
    
    let viewModel: FinancialInformationViewModel = FinancialInformationViewModel()

    private lazy var financialInformationView: FinancialInformationView = {
        return FinancialInformationView(viewModel: viewModel)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
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
        financialInformationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        financialInformationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        financialInformationView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -80).isActive = true
        
    }

}
