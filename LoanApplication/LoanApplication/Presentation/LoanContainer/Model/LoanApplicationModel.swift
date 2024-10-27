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
    
    init(
        personalInfo: PersonalInformationModel = PersonalInformationModel(),
        financialInfo: FinancialInformationModel = FinancialInformationModel()
    ) {
        self.personalInfo = personalInfo
        self.financialInfo = financialInfo
    }
    struct PersonalInformationModel {
        var fullName: String
        var email: String
        var phoneNumber: String
        var gender: String
        var address: String
        
        init(
            fullName: String = "John Doe",
            email: String = "jonhdoe@gmail.com",
            phoneNumber: String = "+64229875477",
            gender: String = "Male",
            address: String = "1 Alliance lane"
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
            annualIncome: String = "$100,000",
            desiredLoanAmount: String = "$50,000",
            irdNumber: String = "123-456-789"
        ) {
            self.annualIncome = annualIncome
            self.desiredLoanAmount = desiredLoanAmount
            self.irdNumber = irdNumber
        }
    }
}
