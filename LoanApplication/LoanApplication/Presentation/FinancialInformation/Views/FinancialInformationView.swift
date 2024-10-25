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
    
    private lazy var annualIncome: LAUITextField = {
        let view: LAUITextField = LAUITextField("Annual Income")
        return view
    }()
    
    private lazy var desiredLoanAmount: LAUITextField = {
        let view: LAUITextField = LAUITextField("Desired Loan Amount")
        view.autocapitalizationType = .none
        return view
    }()
    
    private lazy var irdNumber: LAUITextField = {
        let view: LAUITextField = LAUITextField("IRD Number")
        view.autocapitalizationType = .none
        return view
    }()
    
    private lazy var nextButton: LAUIButton = {
        let button = LAUIButton(configuration: .financialInformationCustomButton)
        button.addTarget(self, action: #selector(onNextButtonPressed), for: .touchUpInside)
        return button
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
        
    }
    
    func setupView() {
        addSubview(annualIncome)
        addSubview(desiredLoanAmount)
        addSubview(irdNumber)
        addSubview(nextButton)
    }
    
    func setupConstraints() {
        annualIncome.translatesAutoresizingMaskIntoConstraints = false
        desiredLoanAmount.translatesAutoresizingMaskIntoConstraints = false
        irdNumber.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            nextButton.topAnchor.constraint(equalTo: irdNumber.bottomAnchor, constant: 50),
            nextButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            nextButton.heightAnchor.constraint(equalToConstant: 56),
            nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
    }
    

}
