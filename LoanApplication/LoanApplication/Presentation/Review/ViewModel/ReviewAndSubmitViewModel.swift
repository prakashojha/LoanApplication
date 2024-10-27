//
//  ReviewAndSubmitViewModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import Foundation

class ReviewAndSubmitViewModel {
    
    var loanApplicationModel: LoanApplicationModel
    var coordinator: AppCoordinator?
    var model: [ReviewAndSubmitModel] = []
    
    init(loanApplicationModel: LoanApplicationModel, coordinator: AppCoordinator? = nil) {
        self.loanApplicationModel = loanApplicationModel
        self.coordinator = coordinator
        prepareReviewAndSummaryModel()
    }
    
    func prepareReviewAndSummaryModel() {
        model.append(.init(title: "Full Name", value: loanApplicationModel.personalInfo.fullName))
        model.append(.init(title: "Email", value: loanApplicationModel.personalInfo.email))
        model.append(.init(title: "Phone Number", value: loanApplicationModel.personalInfo.phoneNumber))
        model.append(.init(title: "Gender", value: loanApplicationModel.personalInfo.gender))
        model.append(.init(title: "Address", value: loanApplicationModel.personalInfo.address))
        model.append(.init(title: "Annual Income", value: loanApplicationModel.financialInfo.annualIncome))
        model.append(.init(title: "Desired Loan Amount", value: loanApplicationModel.financialInfo.desiredLoanAmount))
        model.append(.init(title: "IRD Number", value: loanApplicationModel.financialInfo.irdNumber))
    }
    
    var numberOfRowsInSection: Int {
        return model.count
    }
}
