//
//  LoanApplicationViewController.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 24/10/24.
//

import UIKit

class LoanApplicationViewController: UIViewController {

    private lazy var personalInformationView: PersonalInformationView = {
        let view = PersonalInformationView()
        return view
    }()
    
    private lazy var button: UIView = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setTitle("Next", for: .normal)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        button.addTarget(self, action: #selector(onButtonTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.title = "Personal Information"
        navigationController?.navigationBar.backgroundColor = .cyan
        addView()
        setConstraints()
    }
    
    func addView() {
        self.view.addSubview(personalInformationView)
        self.view.addSubview(button)
    }
    
    @objc func onButtonTap() {
        print("Button Tapped")
    }
    
    func setConstraints() {
        personalInformationView.translatesAutoresizingMaskIntoConstraints = false
        personalInformationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        personalInformationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        personalInformationView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -80).isActive = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 56).isActive = true
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: personalInformationView.bottomAnchor, constant: 50).isActive = true
        
    }
    
}

extension LoanApplicationViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // user presses return key
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

