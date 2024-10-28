//
//  LoanApplicationModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 26/10/24.
//

import Foundation

struct LoanApplicationModel {
    var personalInfo: PersonalInformationModel
    var financialInfo: FinancialInformationModel
    var isComplete: Bool
    var id: UUID
    
    init(
        personalInfo: PersonalInformationModel = PersonalInformationModel(),
        financialInfo: FinancialInformationModel = FinancialInformationModel(),
        isComplete: Bool = false,
        id: UUID
    ) {
        self.personalInfo = personalInfo
        self.financialInfo = financialInfo
        self.isComplete = isComplete
        self.id = id
    }
    struct PersonalInformationModel {
        var fullName: String
        var email: String
        var phoneNumber: String
        var gender: String
        var address: String
        
        init(
            fullName: String = "",
            email: String = "",
            phoneNumber: String = "",
            gender: String = "Male",
            address: String = ""
        ) {
            self.fullName = fullName
            self.email = email
            self.phoneNumber = phoneNumber
            self.gender = gender
            self.address = address
        }
    }
    
    struct FinancialInformationModel {
        var annualIncome: String
        var desiredLoanAmount: String
        var irdNumber: String
        
        init(
            annualIncome: String = "",
            desiredLoanAmount: String = "",
            irdNumber: String = ""
        ) {
            self.annualIncome = annualIncome
            self.desiredLoanAmount = desiredLoanAmount
            self.irdNumber = irdNumber
        }
    }
}
