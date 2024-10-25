//
//  LoanApplicationViewController.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 24/10/24.
//

import UIKit

class LoanApplicationViewController: UIViewController, HideKeyboardProtocol, ShowAlertProtocol {
    
    let viewModel: PersonalInformationViewModel
    
    init(viewModel: PersonalInformationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var personalInformationView: PersonalInformationView = {
        viewModel.alertMessage = { (message, completion) in
            self.showAlert(with: message, completion: completion)
        }
        return PersonalInformationView(viewModel: viewModel)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = "Personal Information"
        addView()
        setConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
    }
    
    func setUpNavigationBar() {

        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .systemBlue

        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
    }
    
    @objc func dismissKeyboardView() {
        view.endEditing(true)
    }
    
    func addView() {
        self.view.addSubview(personalInformationView)
    }
    
    func setConstraints() {
        personalInformationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personalInformationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            personalInformationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            personalInformationView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -20)
        
        ])
        
    }
}

