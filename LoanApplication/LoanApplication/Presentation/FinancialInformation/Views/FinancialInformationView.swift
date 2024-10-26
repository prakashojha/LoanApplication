//
//  FinancialInformationView.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import Foundation
import UIKit

class FinancialInformationView: UIView {
    
    private let viewModel: FinancialInformationViewModel
    
    private lazy var annualIncome: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField(viewModel.annualIncome, labelText: "Annual Income")
        view.textField.tag = 1
        view.textField.delegate = self
        return view
    }()
    
    private lazy var desiredLoanAmount: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField(viewModel.desiredLoanAmount, labelText: "Loan Amount (50% of annual income)")
        view.textField.autocapitalizationType = .none
        view.textField.tag = 2
        view.textField.delegate = self
        return view
    }()
    
    private lazy var irdNumber: LAUIInputField = {
        let view: LAUIInputField = LAUIInputField(viewModel.irdNumber, labelText: "IRD Number")
        view.textField.autocapitalizationType = .none
        view.textField.tag = 3
        view.textField.delegate = self
        return view
    }()
    
    private lazy var previousButton: LAUIButton = {
        let button = LAUIButton(configuration: .navigationCustomButton(title: "Previous"))
        button.addTarget(self, action: #selector(onPreviousButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextButton: LAUIButton = {
        let button = LAUIButton(configuration: .navigationCustomButton(title: "Next"))
        button.addTarget(self, action: #selector(onNextButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var navigationButtonView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.addArrangedSubview(previousButton)
        view.addArrangedSubview(nextButton)
        view.spacing = 10
        return view
    }()
    
    init(viewModel: FinancialInformationViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func onNextButtonPressed() {
        viewModel.onNextButtonPressed(
            annualIncome.textField.text,
            desiredLoanAmount.textField.text,
            irdNumber: irdNumber.textField.text
        )
    }
    
    @objc func onPreviousButtonPressed() {
        viewModel.onPreviousButtonPressed()
    }
    
    func setupView() {
        addSubview(annualIncome)
        addSubview(desiredLoanAmount)
        addSubview(irdNumber)
        addSubview(navigationButtonView)
    }
    
    func setupConstraints() {
        annualIncome.translatesAutoresizingMaskIntoConstraints = false
        desiredLoanAmount.translatesAutoresizingMaskIntoConstraints = false
        irdNumber.translatesAutoresizingMaskIntoConstraints = false
        navigationButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            annualIncome.topAnchor.constraint(equalTo: self.topAnchor),
            annualIncome.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewModel.gapLeft),
            annualIncome.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewModel.gapRight),
            annualIncome.heightAnchor.constraint(equalToConstant: viewModel.viewHeight),
            
            desiredLoanAmount.topAnchor.constraint(equalTo: annualIncome.bottomAnchor, constant: viewModel.gapBetween),
            desiredLoanAmount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewModel.gapLeft),
            desiredLoanAmount.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewModel.gapRight),
            desiredLoanAmount.heightAnchor.constraint(equalToConstant: viewModel.viewHeight),
            
            irdNumber.topAnchor.constraint(equalTo: desiredLoanAmount.bottomAnchor, constant: viewModel.gapBetween),
            irdNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewModel.gapLeft),
            irdNumber.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewModel.gapRight),
            irdNumber.heightAnchor.constraint(equalToConstant: viewModel.viewHeight),
            
            navigationButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            navigationButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            navigationButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            navigationButtonView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

extension FinancialInformationView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the updated text after the replacement
        var updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        guard viewModel.containValidAmount(updatedText: updatedText, replacementString: string) else { return false }
        
        // Directly update the text field to allow typing of decimal part
        textField.text = updatedText
        if let formattedText = viewModel.getFormattedText(updatedText, string, textField.tag) {
            textField.text = formattedText
        }
        return false
    }
}

