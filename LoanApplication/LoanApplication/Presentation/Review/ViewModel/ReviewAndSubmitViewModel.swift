//
//  ReviewAndSubmitViewModel.swift
//  LoanApplication
//
//  Created by Saumya Prakash on 27/10/24.
//

import Foundation
import UIKit
import CoreData

class ReviewAndSubmitViewModel {
    
    var showAlert: ((String) -> Void)?
    
    var loanApplicationModel: LoanApplicationModel
    var coordinator: AppCoordinator?
    var model: [ReviewAndSubmitModel] = []
    
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    private func createModelForCoreData() -> LoanApplicationCDModel {
        
        let model = LoanApplicationCDModel(context: context)
        
        model.fullName = loanApplicationModel.personalInfo.fullName
        model.email = loanApplicationModel.personalInfo.email
        model.phoneNumber = loanApplicationModel.personalInfo.phoneNumber
        model.gender = loanApplicationModel.personalInfo.gender
        model.address = loanApplicationModel.personalInfo.address
        model.annualIncome = loanApplicationModel.financialInfo.annualIncome
        model.desiredLoanAmount = loanApplicationModel.financialInfo.desiredLoanAmount
        model.irdNumber = loanApplicationModel.financialInfo.irdNumber
        model.dateSubmitted = Date()
        
        return model
    }
    
    func onSubmitPressed() {
        let person = PersonCDModel(context: context)
        let loan = createModelForCoreData()
        
        do {
            try saveData(person: person, loan: loan)
            print("Saved Successfully")
        }
        catch(let error) {
            showAlert?(error.localizedDescription)
        }
    }
}

// MARK: Core data implementation
extension ReviewAndSubmitViewModel {
    
    func saveData(person: PersonCDModel, loan: LoanApplicationCDModel) throws {
        person.addToLoans(loan)
        try context.save()
    }
}
