//
//  FinancialInformationModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 25/10/24.
//

import Foundation

struct FinancialInformationModel {
    var annualIncome: String
    var desiredLoanAmount: String
    var irdNumber: String
    
    init(
        annualIncome: String = "$100,000",
        desiredLoanAmount: String = "$50,000",
        irdNumber: String = "123-456-789"
    ) {
        self.annualIncome = annualIncome
        self.desiredLoanAmount = desiredLoanAmount
        self.irdNumber = irdNumber
    }
}
